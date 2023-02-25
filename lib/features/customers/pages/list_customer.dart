import 'package:app_pedido/features/customers/pages/customers/controller/customer_controller.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class ListCustomer extends StatefulWidget {
  final CustomerController controller;

  const ListCustomer({super.key, required this.controller});

  @override
  State<ListCustomer> createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.controller.state.customers.length,
        itemBuilder: (context, index) {
          final customer = widget.controller.state.customers[index];

          return ListTile(
            leading: Text('${customer.id}', style: const TextStyle(fontSize: 14)),
            title: Text(customer.name),
            subtitle: Text(customer.lastname),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 160,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("${customer.name} ${customer.lastname}", style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 16),
                          Text(UtilBrasilFields.obterCpf(customer.cpf), style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: const Text('Fechar'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: PopupMenuButton(
              color: Colors.purple,
              icon: const Icon(Icons.more_vert_rounded),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Editar",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.edit_rounded)
                    ],
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Excluir",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(Icons.delete_rounded)
                    ],
                  ),
                ),
              ],
              onSelected: (item) => {
                if (item == 0)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Editar Cliente'),
                        content: const Row(
                          children: [
                            Text('Form edit'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancelar'),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Salvar'),
                            child: const Text('Salvar'),
                          ),
                        ],
                      ),
                    )
                  }
                else if (item == 1)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Excluir Cliente'),
                        content: const Text('Tem certeza que deseja excluir esse cliente?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Não'),
                            child: const Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.controller.deleteCustomer(customer);
                              Navigator.pop(context);
                            },
                            child: const Text('Sim'),
                          ),
                        ],
                      ),
                    )
                  }
              },
            ),
          );
        },
      ),
    );
  }
}
