(function () {
  $('#digits-sdk').load(function () {
    Digits.init({ consumerKey: 'Jbn2aZGaiEUmyqkl8pwNHDsuE' });
    $('#login').click(onLoginButtonClick);
  });

  /**
   * Launch the Digits login flow.
   */
  function onLoginButtonClick(e) {
    e.preventDefault();

    Digits.logIn()
          .done(onLogin)
          .fail(onLoginFailure);
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

  /**
   * Handle the login once the user has completed the sign in with Digits.
   * We must POST these headers to the server to safely invoke the Digits API
   * and get the logged-in user's data.
   */
  function onDigitsSuccess(response) {
    setDigitsNumber("&#10003; You are awesome.");
  }

  /**
   * Parse OAuth Echo Headers:
   * 'X-Verify-Credentials-Authorization'
   * 'X-Auth-Service-Provider'
   */
  function parseOAuthHeaders(oAuthEchoHeaders) {
    var credentials = oAuthEchoHeaders['X-Verify-Credentials-Authorization'];
    var apiUrl = oAuthEchoHeaders['X-Auth-Service-Provider'];

    return {
      apiUrl: apiUrl,
      credentials: credentials
    };
  }

  // Set the Digits button label (and make sure it is not disabled).
  function setDigitsButton(text) {
    $('#login').text(text).removeAttr('disabled');
  }

  // Set the Digits phone number (and disable the button).
  function setDigitsNumber(phoneNumber) {
    $('#login').html(phoneNumber).attr('disabled', 'disabled');
  }
})();
