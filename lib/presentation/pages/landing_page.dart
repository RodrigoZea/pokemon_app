import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Pokédex',
                      style: GoogleFonts.pixelifySans(
                        textStyle: const TextStyle(
                          fontSize: 50
                        )
                      ),
                    ),
                  OutlinedButton(
                    onPressed: () => context.go('/home'),
                    child: Text(
                      'Continuar',
                      style: GoogleFonts.pixelifySans(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue
                        )
                      ),
                    )
                  )
              ])
            )
    );
  }
}
