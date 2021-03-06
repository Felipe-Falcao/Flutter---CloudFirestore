import 'package:cloud_firestore/cloud_firestore.dart';

class FuncionarioFB {
  final db = FirebaseFirestore.instance;

  /*
   * Função responsável por criar um funcionário.
   */
  Future<void> create(infoFuncionario, userCredential, enderecoId) async {
    final userData = {
      'nome': infoFuncionario.nome,
      'cpf': infoFuncionario.cpf,
      'carteiraTrabalho': infoFuncionario.carteiraTrabalho,
      'dataContratacao': DateTime.now(),
      'email': infoFuncionario.email,
      'refEndereco': enderecoId,
      'telefone': infoFuncionario.telefone,
      'tipoFuncionario': infoFuncionario.tipo,
    };

    await FirebaseFirestore.instance
        .collection('funcionario')
        .doc(userCredential.user.uid)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do funcionário.
   */
  Future<void> update(infoFuncionario, funcionarioId, enderecoId) async {
    final userData = {
      'nome': infoFuncionario.name,
      'cpf': infoFuncionario.cpf,
      'carteiraTrabalho': infoFuncionario.carteiraTrabalho,
      'dataContratacao': infoFuncionario.dataContratacao,
      'email': infoFuncionario.email,
      'refEndereco': db.doc('endereco/' + enderecoId),
      'telefone': infoFuncionario.telefone,
    };

    await db.collection("funcionario").doc(funcionarioId).update(userData);
  }

  /*
   * Função responsável por receber os dados de  funcionário e atualizar
   * o banco de dados.
   */
  Future<void> updatePersonalData(infoFuncionario) async {
    final userData = {
      'nome': infoFuncionario.nome,
      'cpf': infoFuncionario.cpf,
      'email': infoFuncionario.email,
      'telefone': infoFuncionario.telefone,
    };

    await db.collection("funcionario").doc(infoFuncionario.id).update(userData);
  }

  /*
   * Função responsável por receber os dados de  funcionário e atualizar
   * o banco de dados.
   */
  Future<void> updateWorkData(
      carteiraTrabalho, dataContratacao, idFuncionario) async {
    final userData = {
      'carteiraTrabalho': carteiraTrabalho,
      'dataContratacao': dataContratacao,
    };

    await db.collection("funcionario").doc(idFuncionario).update(userData);
  }

  /*
   * Função responsável por deletar funcionário.
   * Exemplo de chamada: await func.delete("muhwBIA3yyO8lGLB4fuepl2YpPD2");
   */
  Future<void> delete(funcionarioId) async {
    await db.collection('funcionario').doc(funcionarioId).delete();
  }

  /*
   * Função responsável por pegar dados de funcionários.
   * Exemplo de leitura:
   * var a = await func.read('23IfKpVrq7RLOzmunlDOCV9YQdu1');
   * print(a['nome']);
   */
  Future<Map<String, dynamic>> read(funcionarioId) async {
    var doc = await db.collection('funcionario').doc(funcionarioId).get();
    return doc.data();
  }

  /*
   * Função responsável por ler todos os funcionarios existentes e retornar um Stream de
   * documentos da coleção funcionário.
   */
  Stream readAll() {
    var doc = db.collection('funcionario').snapshots();
    return doc;
  }

  /*
   * Função responsável por retornar todos os dados de funcionários do banco
   * de dados.
   */
  Future<QuerySnapshot> getFuncionarios() async {
    var querySnapshot = await db.collection('funcionario').get();
    return querySnapshot;
  }

  /*
   * Função responsável por receber um cpf e retornar os dados do funcionário.
   */
  Future<String> getFuncionarioId(data) async {
    var querySnapshot =
        await db.collection('funcionario').where('cpf', isEqualTo: data).get();
    return querySnapshot.docs[0].id;
  }
  //https://petercoding.com/firebase/2020/04/04/using-cloud-firestore-in-flutter/
}
