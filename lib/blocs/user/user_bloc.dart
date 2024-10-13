import 'package:bloc/bloc.dart';
import 'package:flutter_psu_course_review/blocs/user/user_event.dart';
import 'package:flutter_psu_course_review/blocs/user/user_state.dart';
import 'package:flutter_psu_course_review/repositories/user/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(NeedLoginUserState()) {
    on<LoadUserEvent>(_onLoadedUser);
    on<LoadOtherUserEvent>(_onLoadedOtherUser);
    on<CreateUserEvent>(_onCreatedUser);
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
    on<UpdateUserEvent>(_onUpdatedUser);
    on<ChangePasswordUserEvent>(_onChengedPasswordUser);
  }

  _onLoadedUser(LoadUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      try {
        final user = await userRepository.getMeUser();
        emit(ReadyUserState(user: user));
      } catch (e) {
        emit(NeedLoginUserState(responseText: e.toString()));
      }
    }
  }

  _onLoadedOtherUser(LoadOtherUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      final user = await userRepository.getOtherUser(userId: event.userId);
      emit(ReadyUserState(user: user));
    }
  }

  _onCreatedUser(CreateUserEvent event, Emitter<UserState> emit) async {
    final response = await userRepository.createUser(
      email: event.email,
      username: event.username,
      firstName: event.firstName,
      lastName: event.lastName,
      password: event.password,
    );
    emit(NeedLoginUserState(responseText: response));
    add(LoginUserEvent(username: event.username, password: event.password));
  }

  _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async {
    if (state is NeedLoginUserState) {
      final response = await userRepository.loginUser(
          username: event.username, password: event.password);
      if (response == "Logged in successfully") {
        emit(LoadingUserState(responseText: response));
        add(LoadUserEvent());
      } else {
        emit(NeedLoginUserState(responseText: response));
      }
    }
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<UserState> emit) async {
    await userRepository.logoutUser();
    emit(NeedLoginUserState(responseText: ""));
  }

  _onUpdatedUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepository.updateUser(
        userId: event.userId,
        verifyPassword: event.verifyPassword,
        email: event.email,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }

  _onChengedPasswordUser(
      ChangePasswordUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepository.changePasswordUser(
        userId: event.userId,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }
}
