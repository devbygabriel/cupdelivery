String authErrosString(String? error) {
  switch (error) {
    case 'Senha inválida':
      return 'Senha inválida';
    default:
      return 'Um erro indefinido ocorreu';
  }
}

