import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_like_app/features/home/students/controller/students_state.dart';
import 'package:talabat_like_app/features/home/students/model/student_model.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsInitial()) {
    getStudentsStream();
  }
  TextEditingController studentController = TextEditingController();
  TextEditingController studentAgeController = TextEditingController();
  String selectedStudentId = '';
  CollectionReference students = FirebaseFirestore.instance.collection(
    'students',
  );
  Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('students')
      .snapshots();

  getStudentsStream() {
    studentsStream.listen(
      (snapshot) {
        List<Student> studentsList = snapshot.docs.map((doc) {
          return Student(
            id: doc.id,
            name: doc['name'] as String,
            age: doc['age'] as int,
          );
        }).toList();
        emit(StudentsLoaded(studentsList));
      },
      onError: (error) {
        emit(StudentsError('Failed to load students stream: $error'));
      },
    );
  }

  void getStudents() async {
    emit(StudentsLoading());
    try {
      QuerySnapshot snapshot = await students.get();

      List<Student> studentsList = snapshot.docs
          .map(
            (doc) => Student(
              id: doc.id,
              name: doc['name'] as String,
              age: doc['age'] as int,
            ),
          )
          .toList();

      emit(StudentsLoaded(studentsList));
    } catch (e) {
      emit(StudentsError('Failed to load students: $e'));
    }
  }

  selectUpdateStudent(Student student) {
    selectedStudentId = student.id;
    studentController.text = student.name;
    studentAgeController.text = student.age.toString();
  }

  void addStudent() async {
    try {
      await students.add({
        'name': studentController.text,
        'age': int.tryParse(studentAgeController.text) ?? 0,
      });
      getStudents();
    } catch (e) {
      emit(StudentsError('Failed to add student: $e'));
    }
  }

  void updateStudent() async {
    try {
      await students.doc(selectedStudentId).update({
        'name': studentController.text,
        'age': int.tryParse(studentAgeController.text) ?? 0,
      });
      studentController.clear();
      studentAgeController.clear();
      selectedStudentId = '';
    } catch (e) {
      emit(StudentsError('Failed to update student: $e'));
    }
  }

  void deleteStudent() async {
    try {
      await students.doc(selectedStudentId).delete();
    } catch (e) {
      emit(StudentsError('Failed to delete student: $e'));
    }
  }
}
