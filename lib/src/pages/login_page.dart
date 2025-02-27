import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formu_val/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );
    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: -10.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
            padding: EdgeInsets.only(top: 80.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
                SizedBox(
                  height: 10.0,
                  width: double.infinity,
                ),
                Text(
                  'Abel Uc',
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                )
              ],
            ))
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bloc = Provider.of(context); //Recibe

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 240.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(children: <Widget>[
              Text(
                'Ingresado',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 60.0),
              _crearEmail(bloc),
              SizedBox(height: 20.0),
              _crearPassword(bloc),
              SizedBox(
                height: 20.0,
              ),
              _crearBoton(bloc)
            ]),
          ),
          Text('Olvido la contraseña'),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String msg = snapshot.error.toString();
          var fas;
          if (snapshot.hasError) {
            fas = msg;
          } else {
            fas = null;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.deepOrange),
                  hintText: 'abelmihjail@gmail.com',
                  labelText: 'Correo electronico',
                  counterText: snapshot.data,
                  errorText: fas),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String msg = snapshot.error.toString();
          var fas;
          if (snapshot.hasError) {
            fas = msg;
          } else {
            fas = null;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outlined, color: Colors.deepOrange),
                  labelText: 'Contraseña',
                  counterText: snapshot.data,
                  errorText: fas),
              onChanged: bloc.changePassword,
            ),
          );
        });
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValiStream
    return StreamBuilder(
        stream: bloc.formValiStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ElevatedButton(
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
                elevation: MaterialStateProperty.all(0.0),
                backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                textStyle: MaterialStateProperty.all(
                    TextStyle(fontWeight: FontWeight.bold))),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  _login(LoginBloc bloc, BuildContext context) {
    print('----------------------------------------------');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('----------------------------------------------');
    Navigator.pushReplacementNamed(context, 'home');
  }
}
