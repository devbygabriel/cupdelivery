import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cupdelivery/src/config/custom_colors.dart';
import 'package:cupdelivery/src/pages/auth/controller/auth_controller.dart';
import 'package:cupdelivery/src/services/validators.dart';
import 'package:cupdelivery/src/shared/components/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          children: [
            // Email
            CustomTextField(
              icon: Icons.email,
              label: 'Email',
              initialValue: authController.user.email,
              readOnly: true,
            ),

            // Nome
            CustomTextField(
              icon: Icons.person,
              label: 'Nome',
              initialValue: authController.user.name,
              onSave: (value) {
                authController.user.name = value;
              },
            ),

            // Celular
            CustomTextField(
              icon: Icons.phone,
              label: 'Celular',
              initialValue: authController.user.telephone,
              inputFormatters: [phoneFormatter],
              onSave: (value) {
                authController.user.telephone = value;
              },
            ),

            // CPF
            CustomTextField(
              icon: Icons.security,
              label: 'CPF',
              initialValue: authController.user.cpf,
              inputFormatters: [cpfFormatter],
              readOnly: true,
            ),

            // CEP
            CustomTextField(
              icon: Icons.location_on,
              label: 'CEP',
              initialValue: authController.user.zipCode,
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
              initialValue: authController.user.publicPlace,
              validator: nameValidator,
              onSave: (value) {
                authController.user.publicPlace = value;
              },
            ),

            // Número
            CustomTextField(
              icon: Icons.location_on_sharp,
              label: 'Número',
              initialValue: authController.user.number,
              validator: numberValidator,
              onSave: (value) {
                authController.user.number = value;
              },
            ),

            // Complemento
            CustomTextField(
              icon: Icons.comment,
              label: 'Complemento',
              initialValue: authController.user.complement,
              onSave: (value) {
                authController.user.complement = value;
              },
            ),

            // Cidade
            CustomTextField(
              icon: Icons.location_city,
              label: 'Cidade',
              initialValue: authController.user.city,
              validator: cityValidator,
              onSave: (value) {
                authController.user.city = value;
              },
            ),

            // Estado
            CustomTextField(
              icon: Icons.location_city,
              label: 'Estado',
              initialValue: authController.user.district,
              validator: cityValidator,
              onSave: (value) {
                authController.user.district = value;
              },
            ),

            // Botão atualizar
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GetX<AuthController>(
                      builder: (authController) {
                        return SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(
                                  width: 2,
                                  color: CustomColors.customSwatchColor,
                                ),
                              ),
                            ),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      authController.updateUser();
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    'Atualizar dados',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              width: 2,
                              color: CustomColors.customSwatchColor,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            updatePassword();
                          });
                        },
                        child: const Text(
                          'Atualizar senha',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool?> updatePassword() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final formPasswordKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formPasswordKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Título
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Text(
                            'Atualização de senha',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        // Senha
                        CustomTextField(
                          controller: currentPasswordController,
                          icon: Icons.lock,
                          label: 'Senha atual',
                          isSecret: true,
                          validator: passwordValidator,
                        ),

                        // Nova senha
                        CustomTextField(
                          controller: newPasswordController,
                          icon: Icons.lock_outline,
                          label: 'Nova senha',
                          isSecret: true,
                          validator: passwordValidator,
                        ),

                        // Confirmar senha
                        CustomTextField(
                          icon: Icons.lock_outline,
                          label: 'Confirmar nova senha',
                          isSecret: true,
                          validator: (password) {
                            final result = passwordValidator(password);

                            if (result != null) {
                              return result;
                            }

                            if (password != newPasswordController.text) {
                              return 'As senhas não são iguais';
                            }

                            return null;
                          },
                        ),

                        // Confirmar
                        SizedBox(
                          height: 50,
                          child: Obx(
                            (() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: BorderSide(
                                        width: 2,
                                        color: CustomColors.customSwatchColor,
                                      ),
                                    ),
                                  ),
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();

                                          if (formPasswordKey.currentState!
                                              .validate()) {
                                            formPasswordKey.currentState!
                                                .save();
                                            authController.changePassword(
                                              currentPassword:
                                                  currentPasswordController
                                                      .text,
                                              newPassword:
                                                  newPasswordController.text,
                                            );
                                          }
                                        },
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'Confirmar',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
