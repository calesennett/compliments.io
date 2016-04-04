# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  onLoginButtonClick = (event) ->
    Digits.logIn().done(onLogin).fail onLoginFailure
    return false

  onLogin = (loginResponse) ->
    oAuthHeaders = parseOAuthHeaders(loginResponse.oauth_echo_headers)
    setDigitsButton 'Signing In…'
    $.post
      url: '/digits'
      data: oAuthHeaders
    return

  onLoginFailure = (loginResponse) ->
    setDigitsButton 'Sign Up with Phone'
    return

  parseOAuthHeaders = (oAuthEchoHeaders) ->
    credentials = oAuthEchoHeaders['X-Verify-Credentials-Authorization']
    apiUrl = oAuthEchoHeaders['X-Auth-Service-Provider']
    {
      apiUrl: apiUrl
      credentials: credentials
    }

  setDigitsButton = (text) ->
    $('#login').text(text).removeAttr 'disabled'
    return

  # Set the Digits phone number (and disable the button).

  $('#digits-sdk').load ->
    Digits.init(consumerKey: 'Jbn2aZGaiEUmyqkl8pwNHDsuE')
    $('#login').click onLoginButtonClick
    return
  return
