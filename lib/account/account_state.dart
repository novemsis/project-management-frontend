sealed class AccountState {
  const AccountState();

  factory AccountState.none() = AccountStateNone;

  factory AccountState.loggedIn() = AccountStateLoggedIn;
}

final class AccountStateNone extends AccountState {
  const AccountStateNone();
}

final class AccountStateLoggedIn extends AccountState {
  const AccountStateLoggedIn();
}
