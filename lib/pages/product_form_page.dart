import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _desctiptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _desctiptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de produto"),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"
                    // labelStyle: TextStyle(color: Colors.purple),
                    ),
                // onFieldSubmitted: (_) {
                //   FocusScope.of(context).requestFocus(_priceFocus);
                // },
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (nameField) {
                  String name = nameField ?? "";

                  if (name.trim().isEmpty) {
                    return 'Nome é obrigatório.';
                  }
                  if (name.trim().length < 3) {
                    return 'Nome precisa no mínimo de três letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço"),
                focusNode: _priceFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_desctiptionFocus);
                },
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? "0"),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                focusNode: _desctiptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Url da Imagem"),
                      focusNode: _imageUrlFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submitForm(),
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Informe a URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
