import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';
import 'package:cupdelivery/src/pages/auth/controller/auth_controller.dart';
import 'package:cupdelivery/src/services/validators.dart';
import 'package:cupdelivery/src/shared/components/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor,
        title: const Text(
          'Cadastro',
        ),
      ),
      body: SingleChildScrollView(
        reverse: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email
                CustomTextField(
                  icon: Icons.email,
                  label: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validator: emailValidator,
                  onSave: (value) {
                    authController.user.email = value;
                  },
                ),

                // Senha
                CustomTextField(
                  icon: Icons.lock,
                  label: 'Senha',
                  isSecret: true,
                  validator: passwordValidator,
                  onSave: (value) {
                    authController.user.password = value;
                  },
                ),

                // Nome
                CustomTextField(
                  icon: Icons.person,
                  label: 'Nome',
                  validator: nameValidator,
                  onSave: (value) {
                    authController.user.name = value;
                  },
                ),

                // Celular
                CustomTextField(
                  icon: Icons.phone,
                  label: 'Celular',
                  textInputType: TextInputType.phone,
                  inputFormatters: [phoneFormatter],
                  validator: phoneValidator,
                  onSave: (value) {
                    authController.user.telephone = value;
                  },
                ),

                // CPF
                CustomTextField(
                  icon: Icons.security,
                  label: 'CPF',
                  textInputType: TextInputType.number,
                  inputFormatters: [cpfFormatter],
                  validator: cpfValidator,
                  onSave: (value) {
                    authController.user.cpf = value;
                  },
                ),

                // CEP
                CustomTextField(
                  icon: Icons.location_on,
                  label: 'CEP',
                  textInputType: TextInputType.number,
                  inputFormatters: [cepFormatter],
                  validator: cepValidator,
                  onSave: (value) {
                    authController.user.zipCode = value;
                  },
                ),

                // Endereço
                CustomTextField(
                  icon: Icons.location_on_sharp,
                  label: 'Endereço',
                  validator: nameValidator,
                  onSave: (value) {
                    authController.user.publicPlace = value;
                  },
                ),

                // Número
                CustomTextField(
                  icon: Icons.location_on_sharp,
                  label: 'Número',
                  validator: numberValidator,
                  onSave: (value) {
                    authController.user.number = value;
                  },
                ),

                // Complemento
                CustomTextField(
                  icon: Icons.comment,
                  label: 'Complemento',
                  onSave: (value) {
                    authController.user.complement = value;
                  },
                ),

                // Cidade
                CustomTextField(
                  icon: Icons.location_city,
                  label: 'Cidade',
                  validator: cityValidator,
                  onSave: (value) {
                    authController.user.city = value;
                  },
                ),

                // Estado
                CustomTextField(
                  icon: Icons.location_city,
                  label: 'Estado',
                  validator: cityValidator,
                  onSave: (value) {
                    authController.user.district = value;
                  },
                ),

                // Botão cadastrar
                SizedBox(
                  height: 50,
                  child: GetX<AuthController>(
                    builder: (authController) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: authController.isLoading.value
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  authController.singUp();
                                }
                              },
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
