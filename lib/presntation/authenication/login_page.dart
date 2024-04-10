import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids/presntation/authenication/bloc/login/login_bloc.dart';
import 'package:maids/presntation/authenication/bloc/validate/validate_bloc.dart';
import 'package:maids/presntation/tasks/tasks_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Sign in",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const Text(
                    "(Please sign in to this app so you can Create, Update, Delete your daily tasks)",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h,),
                  const Text("Exp\n Usename: kminchelle\nPassword: 0lelplR",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey,),),
                ],
              ),
              Form(
                  child: Column(
                    children: [

                      TextField(
                        controller: usernameController,
                        onChanged: (text){
                          BlocProvider.of<ValidateBloc>(context).add(OnInputChangeChange(text, passController.text.trim()));

                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.account_circle_outlined),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 1),
                          ),
                          hintText: 'Enter your username',
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passController,
                        onChanged: (text){
                          BlocProvider.of<ValidateBloc>(context).add(OnInputChangeChange(text, passController.text.trim()));
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.lock),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.lightBlueAccent, width: 1),
                          ),
                          hintText: 'Enter your password',
                        ),
                      ),
                    ],
                  )),
              BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) {
                        return const TasksPage();
                      }));
                    }
                    if(state is LoginError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  }, builder: (context, state) {
                return state is LoginLoading ?
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.r)),
                  child: const Center(
                    child:  SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
                    ),
                  ),
                ) :
                BlocBuilder<ValidateBloc, ValidateState>(
                  builder: (context, state) {
                    return Material(child:
                    InkWell(
                      onTap: state is ValidateSuccess? (){
                        BlocProvider.of<LoginBloc>(context).add(Login(
                            username: usernameController.text.trim(),
                            password: passController.text.trim()));
                      }: null,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                            color: state is ValidateSuccess? Colors.black: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.r)),
                        child: Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                    ));
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
