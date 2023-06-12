import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('assets/logo/myliblogo.png'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff273043),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(size.width, 40),
                  )),
              child: Text(
                'Google',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
