
var ACTIVE_USER = null;

steem.api.setOptions({ url: STEEMIT_API_URL});

function loadDataAnon (pendingLogin) {
  if (!pendingLogin) {
    populateVotes();
  }
}

function loadDataAuthenticated () {
  populateVotes();
}




$(document).ready(function () {
  console.log('ready');
  var isPendingLogin = window.sessionStorage && window.sessionStorage.getItem('steemit-active-user') != null;
  
  loadDataAnon(isPendingLogin);
});

sessionLogin();

function sessionLogin () {
  if (window.sessionStorage) {
    var s = window.sessionStorage;
    var activeUser = s.getItem('steemit-active-user');
  
    if (activeUser) {
      activeUser = JSON.parse(activeUser);
      login(activeUser.username, activeUser.postingKey, function (err, account) {
        if (err) {
          return;
        }
        loadDataAuthenticated();
      });
    }
  }
}

function storeSessionLogin() {
  if (window.sessionStorage) {
    var s = window.sessionStorage;
    s.setItem('steemit-active-user', JSON.stringify({username: ACTIVE_USER.username, postingKey: ACTIVE_USER.postingKey}));
  }
}

function login (username, postingKey, cb) {

  if (!steem.auth.isWif(postingKey)) {
    cb('login-invalid-postingKey');
    return;
  }

  steem.api.getAccounts([username], function (err, accounts) {
    if (err) {
      console.log('could not login: ' + err);
      if (cb) {
        cb('login-unknown');
      }
      return;
    }

    if (accounts.length > 1) {
      console.log('multiple accounts are not implemented... not picking a default. bug me or send a pull request');
      if (cb) {
        cb('login-multiple-accounts-not-implemented');
      }
      return;
    }

    var account = accounts[0];
    
    
    var pubWif = account.posting.key_auths[0][0];
    var isValid = steem.auth.wifIsValid(postingKey, pubWif);
    
    if (!isValid) {
      cb('login-invalid');
      return;
    }
    
    ACTIVE_USER = {
      username: username,
      postingKey: postingKey,
      account: account
    };

    if (cb) {
      cb(null, ACTIVE_USER);
    }
  });
}

function postsByTag (tag, limit) {
  limit = limit || 5; // todo: is 0 valid/no limit/default limit?
  steem.api.getDiscussionsByBlog({tag: tag, limit: limit}, function(err, result) {
    console.log(err, result);
  });
}

function votes (cb) {
  steem.api.getActiveVotes(STEEMIT_AUTHOR, STEEMIT_PERMLINK, function (err, votes) {
    if (err) {
      console.log('error getting votes: ' + err);
      if (cb) {
        cb('votes-unknown');
      }
      return;
    }

    if (cb) {
      cb(null, votes);
    }
  });
}

function vote (weight, power, cb) {
  if (!ACTIVE_USER) {
    console.err('could not vote because not logged in');
    if (cb) {
      cb('vote-not-logged-in');
    }
    return;
  }
  
  weight = weight || 100;
  power = power || 100;

  var voter = ACTIVE_USER.account.name;
  var voteWeight = power * weight;
  
  steem.broadcast.vote(ACTIVE_USER.postingKey, voter, STEEMIT_AUTHOR, STEEMIT_PERMLINK, voteWeight, function (err, result) {
    if (err) {
      console.error('could not vote: ' + err);
      if (cb) {
        cb('vote-unknown');
      }
      return;
    }
    
    if (cb) {
      cb();
    }
  });
}

function logoutUser (loginFormId) {
  if (window.sessionStorage) {
    var s = window.sessionStorage;
    s.removeItem('steemit-active-user');
  }

  ACTIVE_USER = null;

  loadDataAuthenticated();
  cancelLoginUser(loginFormId);
}

function cancelLoginUser (loginFormId) {
  $('#' + loginFormId + '-container').hide();
  $('#' + loginFormId + '-button').show();
}


function loginUser (loginFormId) {
  var loginForm = $('#' + loginFormId);
  var username = $('.username', loginForm).val();
  var postingKey = $('.postingKey', loginForm).val();

  var errorMessageBox = $('.error-message', loginForm);
  
  if (!username || !postingKey) {
    errorMessageBox.text('Enter values into the fields');
    return;  
  }

  login(username, postingKey, function (err, activeUser) {
    if (err) {
      if (err == 'login-invalid') {
        errorMessageBox.text('Invalid login');
      } else if (err == 'login-invalid-postingKey') {
        errorMessageBox.text('Invalid private posting key');
      } else {
        errorMessageBox.text('Unknown error');
      }
      return;
    }

    errorMessageBox.text('');
    storeSessionLogin();
    loadDataAuthenticated();

    cancelLoginUser(loginFormId);
  });
}

// permlink = permlink for article (add to post)
// author = author for article (add to post)

// wif = wif(username, postingKey)
// voter = accounts(username)[0] // multiple accounts (dialog)
// weight = dialog for voting weight

// vote(wif, voter, author, permlink, weight)

// postsByTag('{{ steemit-tag }}', 5)

function voteUp () {
  console.log("voteUp");
  vote(100, null, populateVotes);
}

function voteDown () {
  console.log("voteDown");
  vote(-100, null, populateVotes);

}

function populateVotes () {
  votes(function(err, activeVotes) {
    if (err) {
      return;
    }
    
    var ups = [], downs = [], activeUserVote = null;
    activeVotes.forEach(function (v) {
      if (ACTIVE_USER && ACTIVE_USER.account.name == v.voter) {
        activeUserVote = v;
      }
      if (v.percent > 0) {
        ups.push(v);
      } else if (v.percent < 0) {
        downs.push(v);
      } else {
        console.log('0 weight vote... not counting');
      }
    });

    var voteEl = $('#vote-video');

    if (ups.length) {
      $('.vote-up .count', voteEl).text('(' + ups.length + ')');
    } else {
      $('.vote-up .count', voteEl).text('');
    }

    if (downs.length) {
      $('.vote-down .count', voteEl).text('(' + downs.length + ')');
    } else {
      $('.vote-down .count', voteEl).text('');
    }

    if (activeUserVote) {
      if (activeUserVote.percent > 0) {
        $('.vote-up .count', voteEl).css('font-weight', 'bold');
        $('.vote-down .count', voteEl).css('font-weight', 'normal');
      } else {
        $('.vote-up .count', voteEl).css('font-weight', 'normal');
        $('.vote-down .count', voteEl).css('font-weight', 'bold');
      }
    } else {
      $('.vote-up .count', voteEl).css('font-weight', 'normal');
      $('.vote-down .count', voteEl).css('font-weight', 'normal')    }
  });
}
