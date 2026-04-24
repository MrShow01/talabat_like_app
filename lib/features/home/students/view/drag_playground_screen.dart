import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/home/students/controller/students_cubit.dart';
import 'package:talabat_like_app/features/home/students/controller/students_state.dart';

class DragPlaygroundScreen extends StatelessWidget {
  const DragPlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => StudentsCubit(),
        child: BlocBuilder<StudentsCubit, StudentsState>(
          builder: (context, state) {
            if (state is StudentsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (state is StudentsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is StudentsLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: context
                          .read<StudentsCubit>()
                          .studentController,
                      decoration: InputDecoration(
                        labelText: 'Enter student name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextFormField(
                      controller: context
                          .read<StudentsCubit>()
                          .studentAgeController,
                      decoration: InputDecoration(
                        labelText: 'Enter student Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Row(
                      spacing: 16,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<StudentsCubit>().addStudent();
                          },
                          child: Text('Add Student'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<StudentsCubit>().updateStudent();
                          },
                          child: Text('Update Student'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<StudentsCubit>().getStudents();
                      },
                      child: Text('Get Students'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.students[index].name),
                          subtitle: Text('Age: ${state.students[index].age}'),
                          trailing: IconButton(
                            onPressed: () {
                              context.read<StudentsCubit>().selectUpdateStudent(
                                state.students[index],
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              context.read<StudentsCubit>().selectedStudentId =
                                  state.students[index].id;
                              context.read<StudentsCubit>().deleteStudent();
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('There is no students yet'));
          },
        ),
      ),
    );
  }
}
