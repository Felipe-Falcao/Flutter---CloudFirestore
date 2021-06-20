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
      'carteiraTrabalho': '123456',
      'dataContratacao': DateTime.now(),
      'email': infoFuncionario.email,
      'refEndereco': enderecoId,
      'telefone': '79 99999999'
    };

    await FirebaseFirestore.instance
        .collection('funcionario')
        .doc(userCredential.user.uid)
        .set(userData);
  }

  /*
   * Função responsável por modificar dados do funcionário.
   * Exemplo de chamada:
   * await func.update(authData, 'BYo4qMI6ZTQkVK4fKhcwCLQuJyP2', 'null', 'null');
   */
  Future<void> update(infoFuncionario, funcionarioId, enderecoId) async {
    final userData = {
      'nome': infoFuncionario.name,
      'cpf': infoFuncionario.cpf,
      'carteiraTrabalho': '1234567',
      'dataContratacao': DateTime.now(),
      'email': infoFuncionario.email,
      'refEndereco': db.doc('endereco/' + enderecoId),
      'telefone': '79 99999999'
    };

    await db.collection("funcionario").doc(funcionarioId).update(userData);
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

  Future<String> getFuncionarioId(data) async {
    var querySnapshot =
        await db.collection('funcionario').where('cpf', isEqualTo: data).get();
    return querySnapshot.docs[0].id;

    // db
    //     .collection('funcionario')
    //     .where('cpf', isEqualTo: data)
    //     .get()
    //     .then((value) => {
    //           value.docs.forEach((doc) {
    //             print(doc.id);
    //             // print(doc.data());
    //           })
    //         });
  }
  //https://petercoding.com/firebase/2020/04/04/using-cloud-firestore-in-flutter/
}
