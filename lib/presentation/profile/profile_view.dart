import 'package:flutter/material.dart';
import 'package:mylib_app/repository/auth_repository.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .5,
              width: MediaQuery.of(context).size.width * .5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff9197AE).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff9197AE).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9197AE).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.network(
                      "https://picsum.photos/1000",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Doğukan Özgür Yılmaz",
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff273043),
                ),
                minimumSize: MaterialStateProperty.all(Size(size.width, 40)),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Profili düzenle',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                  Container(
                    width: 70,
                    padding: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0xff273043),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const InfoContainer(title: "Kitap", value: "8"),
            const SizedBox(height: 5),
            const InfoContainer(title: "Sayfa", value: "3400"),
            const SizedBox(height: 5),
            const InfoContainer(title: "Kelime", value: "640000"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AuthRepository authRepository = AuthRepository();
                authRepository.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red[300],
                ),
              ),
              child: Text(
                'Çıkış yap',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final String value;

  const InfoContainer({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff9197AE)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalDivider(
            endIndent: 5,
            indent: 5,
          ),
          const SizedBox(height: 5),
          SizedBox(width: 70, child: Text(title)),
        ],
      ),
    );
  }
}
