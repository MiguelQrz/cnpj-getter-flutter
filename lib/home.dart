import 'package:cnpj_getter/api/main.dart';
import 'package:cnpj_getter/misc/widgets_formatters.dart';
import 'package:cnpj_getter/models/cnpj.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  CnpjData? result;
  

  void _askAPI(String cnpj) async {
    setState(() {
      _isLoading = true;
    });
    final response = await apiCall(cnpj);
    if (response == null){
      setState(() {
        _isLoading = false;
        _errorMessage = "Erro ao buscar dados. Verifique o CNPJ e tente novamente.";
        result = null;
      });
    }else{
      setState(() {
        _isLoading = false;
        _errorMessage = null;
        result = response;          
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Busca CNPJ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: 
      SingleChildScrollView(
        child: 
      Form(
        key: _formKey,
        child: 
      SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(16),
        child:
         Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Digite o CNPJ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _controller,
                    inputFormatters: [CnpjInputFormatter()],
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: "00.000.000/0000-00",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um CNPJ';
                      }
                      final numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
                      if (numbers.length != 14) {
                        return 'CNPJ inválido';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Resultado",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: 
                    _errorMessage != null ? Colors.redAccent.withValues(alpha: 0.1) : Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                    child:
                  _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  )
                : result == null
                    ? const Text("Nenhum dado ainda...")
                    : Column(
                        children: [

                          buildSection("Dados Gerais", [
                            buildField("CNPJ", result!.cnpj),
                            buildField("Razão Social", result!.razaoSocial),
                            buildField("Fantasia", result!.nomeFantasia),
                            buildField("Situação", result!.situacaoCadastral),
                            buildField("Tipo", result!.matrizFilial),
                            buildField("Porte", result!.porteEmpresa),
                          ]),

                          buildSection("Endereço", [
                            buildField("Logradouro", result!.logradouro),
                            buildField("Número", result!.numero),
                            buildField("Bairro", result!.bairro),
                            buildField("Cidade", result!.municipio),
                            buildField("UF", result!.uf),
                            buildField("CEP", result!.cep),
                          ]),

                          buildSection("Contato", [
                            buildField("Telefone", result!.telefones.map((t) => t.numero).join(", ")),
                            buildField("Email", result!.email),
                          ]),

                          if (result!.qsa.isNotEmpty)
                            buildSection(
                              "Sócios",
                              result!.qsa.map<Widget>((s) => buildSocioCard(s)).toList(),
                            ),
                        ],
                      ),
                  )])),
                ],
              ),
            ),
        ),
      )),
      bottomNavigationBar: 
    SafeArea(child:
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
    SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  if (_formKey.currentState!.validate()){
                  _askAPI(_controller.text)},
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: 
                _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    :
                const Text(
                  "CONSULTAR",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            )),
    
    )
    );
  }
}