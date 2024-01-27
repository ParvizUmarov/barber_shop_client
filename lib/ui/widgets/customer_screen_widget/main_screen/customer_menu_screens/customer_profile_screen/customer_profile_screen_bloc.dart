
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../domain/services/firebase_service/user_state.dart';
import '../../../../../navigation/go_router_navigation.dart';


class CustomerProfileScreenBloc extends Cubit<UserState>{

  CustomerProfileScreenBloc() : super(
      UserState(currentUserId: FirebaseAuth.instance.currentUser?.uid)
  );

  void signOut() {
    FirebaseAuth.instance.signOut();
    router.pushReplacementNamed('/');
    emit(state);
  }

  

}





// StreamBuilder(
// stream: FirebaseAuth.instance.authStateChanges(),
// builder: (context, snapshot) {
// final user = snapshot.data;
// final uid = user?.uid;
// final customers =
// FirebaseFirestore.instance.collection('Customers');
// return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
// future: customers.doc(uid).get(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return Center(
// child: CircularProgressIndicator(
// color: AppColors.mainColor,
// ),
// );
// } else if (snapshot.hasError) {
// return Center(child: Text('Упс... Что та пошло не так'));
// } else {
// if (snapshot.hasData) {
// final name = snapshot.data?['name'];
// final email = snapshot.data?['email'];
// final surname = snapshot.data?['surname'];
// final phone = snapshot.data?['phone'];
// double height = MediaQuery.of(context).size.height;
//
// return _CustomerProfileWidget(
// height: height,
// name: name,
// surname: surname,
// email: email,
// phone: phone);
// } else {
// return Center(child: Text('Нет данных'));
// }
// }
// });
// },
// )
