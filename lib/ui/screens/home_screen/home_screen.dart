import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_task/ui/screens/home_screen/home_screen_bloc/home_screen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeScreenBloc>().add(const GetRepoDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state.gitDataStatus == GitDataStatus.refreshed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(child: Text('Data refreshed completed'))));
          }
        },
        builder: (context, state) {
          if (state.gitDataStatus == GitDataStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.gitDataStatus == GitDataStatus.loaded ||
              state.gitDataStatus == GitDataStatus.refreshed) {
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<HomeScreenBloc>()
                    .add(const GetRepoDataEvent(isRefresh: true));
              },
              child: ListView.builder(
                itemCount: state.gitSearchDataList.length,
                itemBuilder: (context, index) {
                  final item = state.gitSearchDataList[index];
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.indigo[100]),
                    child: ListTile(
                      title: Text('Name: ${item.name ?? 'Default Name'}'),
                      subtitle: Text(
                          'Description: ${item.description ?? 'No description'}'),
                    ),
                  );
                },
              ),
            );
          } else if (state.gitDataStatus == GitDataStatus.empty) {
            return const Center(child: Text('No data found'));
          } else if (state.gitDataStatus == GitDataStatus.failure) {
            return const Center(child: Text('Failed to load data'));
          } else {
            return const Center(child: Text('Start by loading data'));
          }
        },
      ),
    );
  }
}
