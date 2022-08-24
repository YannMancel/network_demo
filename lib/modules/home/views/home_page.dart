import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, ConsumerWidget, WidgetRef;
import 'package:network_demo/_features.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});

  final String title;

  Future<void> _onPressed(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(userLogicRef).addUser();

    context.notify = result.when<String>(
      data: (user) => '${user!.name} has been added.',
      error: (e) => 'An error has occurred',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUsers = ref.watch(usersRef);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: asyncUsers.when<Widget>(
        data: (result) => result.when<Widget>(
          data: (users) => _HomeView(users: users!),
          error: (e) => ErrorWidget(e),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        error: (e, _) => ErrorWidget(e),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressed(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(
        child: Text('No data'),
      );
    }

    return ListView.builder(
      itemBuilder: (_, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
        );
      },
      itemCount: users.length,
    );
  }
}
