String getErrorString(String code) {
  switch (code) {
    case 'weak-password':
      return 'Sua senha é muito fraca.';
    case 'invalid-email':
      return 'Seu e-mail é inválido.';
    case 'email-already-in-use':
      return 'E-mail já está sendo utilizado em outra conta.';
    case 'invalid-credential':
      return 'Seu e-mail é inválido.';
    case 'wrong-password':
      return 'Sua senha está incorreta.';
    case 'user-not-found':
      return 'Não há usuário com este e-mail.';
    case 'user-disabled':
      return 'Este usuário foi desabilitado.';
    case 'too-many-requests':
      return 'Muitas solicitações. Tente novamente mais tarde.';
    case 'invalid-phone-number':
      return 'O número de telefone fornecido não é válido.';
    case 'invalid-verification-code':
      return 'Código fornecido inválido';
    case 'operation-not-allowed':
      return 'Operação não permitida.';
    case 'network-request-failed':
      return 'Falha de rede.';
    default:
      return 'Um erro indefinido ocorreu $code';
  }
}
