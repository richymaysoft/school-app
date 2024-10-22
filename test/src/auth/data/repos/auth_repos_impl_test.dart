import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/auth/data/datasource/datasource.dart';

void main() {
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage storageClient;
  late FakeFirebaseFirestore dbClient;
  late DataSource dataSource;

  setUp(() async {
    // Mock sign in with Google.
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in.
    final mockuser = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final auth = MockFirebaseAuth(mockUser: mockuser);
    final result = await auth.signInWithCredential(credential);
    final user = result.user;
    print(user!.displayName);

    authClient = MockFirebaseAuth();
    storageClient = MockFirebaseStorage();
    dbClient = FakeFirebaseFirestore();
    dataSource = RemoteDataSourceImpl(
        firebaseAuth: authClient,
        firebaseFirestore: dbClient,
        firebaseStorage: storageClient);
  });

  const kName = 'some name';
  const kEmail = 'someemail@gmail.com';
  const kPassword = '12345';

  test('signUp', () async {
    await dataSource.signUp(name: kName, email: kEmail, password: kPassword);

    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.email, kEmail);
  });

  test('sign in', () async {
    await dataSource.signUp(name: kName, email: kEmail, password: kPassword);
    await authClient.signOut();

    await dataSource.signIn(email: kEmail, password: kPassword);
    expect(authClient.currentUser, isNotNull);
  });
}
