(function () {
  $('#digits-sdk').load(function () {
    Digits.init({ consumerKey: 'Jbn2aZGaiEUmyqkl8pwNHDsuE' })
      .done(function() {
        $('#login').on('click', onLoginButtonClick);
      });
  });

  function onLoginButtonClick(event) {
    Digits.logIn().done(onLogin).fail(onLoginFailure);
    return false;
  }

  function onLogin(loginResponse) {
    var oAuthHeaders = parseOAuthHeaders(loginResponse.oauth_echo_headers);

    setDigitsButton('Signing In…');
    $.ajax({
      type: 'POST',
      url: '/digits',
      data: oAuthHeaders,
      success: onDigitsSuccess
    });
  }

  /**
   * Handle the login failure.
   */
  function onLoginFailure(loginResponse) {
    setDigitsButton('Sign up with Phone');
  }

  function onDigitsSuccess(response) {
    setDigitsNumber(response.phoneNumber);
  }

  function parseOAuthHeaders(oAuthEchoHeaders) {
    var credentials = oAuthEchoHeaders['X-Verify-Credentials-Authorization'];
    var apiUrl = oAuthEchoHeaders['X-Auth-Service-Provider'];

    return {
      apiUrl: apiUrl,
      credentials: credentials
    };
  }

  function setDigitsButton(text) {
    $('#login').text(text).removeAttr('disabled');
  }

  // Set the Digits phone number (and disable the button).
  function setDigitsNumber(phoneNumber) {
    $('#login').html('&#10003; You are awesome');
  }
})();
