import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/system/state.dart';
import 'package:lunasea/router/router.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/types/exception.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

class LunaProfileTools {
  bool changeTo(
    String profile, {
    bool showSnackbar = true,
    bool popToRootRoute = false,
  }) {
    try {
      if (LunaSeaDatabase.ENABLED_PROFILE.read() == profile) return true;
      _changeTo(profile);

      if (showSnackbar) {
        showLunaSuccessSnackBar(
          title: 'settings.ChangedProfile'.tr(),
          message: profile,
        );
      }

      if (popToRootRoute) {
        LunaRouter().popToRootRoute();
      }

      return true;
    } on ProfileNotFoundException catch (error, trace) {
      LunaLogger().exception(error, trace);
    }
    return false;
  }

  Future<bool> create(
    String profile, {
    bool showSnackbar = true,
  }) async {
    try {
      await _create(profile);
      _changeTo(profile);

      if (showSnackbar) {
        showLunaSuccessSnackBar(
          title: 'settings.AddedProfile'.tr(),
          message: profile,
        );
      }
    } on ProfileAlreadyExistsException catch (error, trace) {
      LunaLogger().exception(error, trace);
    } catch (error, trace) {
      LunaLogger().error('Failed to create profile', error, trace);
    }

    return false;
  }

  Future<bool> remove(
    String profile, {
    bool showSnackbar = true,
  }) async {
    try {
      await _remove(profile);

      if (showSnackbar) {
        showLunaSuccessSnackBar(
          title: 'settings.DeletedProfile'.tr(),
          message: profile,
        );
      }
    } on ProfileNotFoundException catch (error, trace) {
      LunaLogger().exception(error, trace);
    } on ActiveProfileRemovalException catch (error, trace) {
      LunaLogger().exception(error, trace);
    } catch (error, trace) {
      LunaLogger().error('Failed to delete profile', error, trace);
    }

    return false;
  }

  Future<bool> rename(
    String oldProfile,
    String newProfile, {
    bool showSnackbar = true,
  }) async {
    try {
      await _rename(oldProfile, newProfile);

      if (showSnackbar) {
        showLunaSuccessSnackBar(
          title: 'settings.RenamedProfile'.tr(),
          message: 'settings.ProfileToProfile'.tr(
            args: [oldProfile, newProfile],
          ),
        );
      }

      return true;
    } on ProfileNotFoundException catch (error, trace) {
      LunaLogger().exception(error, trace);
    } on ProfileAlreadyExistsException catch (error, trace) {
      LunaLogger().exception(error, trace);
    } catch (error, trace) {
      LunaLogger().error('Failed to rename profile', error, trace);
    }

    return false;
  }

  void _changeTo(String profile) {
    if (!LunaBox.profiles.contains(profile)) {
      throw ProfileNotFoundException(profile);
    }

    LunaSeaDatabase.ENABLED_PROFILE.update(profile);
    LunaState.reset();
  }

  Future<void> _create(String profile) async {
    if (LunaBox.profiles.contains(profile)) {
      throw ProfileAlreadyExistsException(profile);
    }

    await LunaBox.profiles.update(profile, LunaProfile());
  }

  Future<void> _remove(String profile) async {
    if (LunaSeaDatabase.ENABLED_PROFILE.read() == profile) {
      throw ActiveProfileRemovalException(profile);
    }

    if (!LunaBox.profiles.contains(profile)) {
      throw ProfileNotFoundException(profile);
    }

    await LunaBox.profiles.delete(profile);
  }

  Future<void> _rename(String oldProfile, String newProfile) async {
    if (!LunaBox.profiles.contains(oldProfile)) {
      throw ProfileNotFoundException(oldProfile);
    }

    if (LunaBox.profiles.contains(newProfile)) {
      throw ProfileAlreadyExistsException(newProfile);
    }

    final oldDb = LunaBox.profiles.read(oldProfile)!;
    final newDb = LunaProfile.clone(oldDb);

    await LunaBox.profiles.update(newProfile, newDb);
    _changeTo(newProfile);

    oldDb.delete();
  }
}

class ProfileNotFoundException with ErrorExceptionMixin {
  final String profile;
  const ProfileNotFoundException(this.profile);

  @override
  String toString() {
    return 'ProfileNotFoundException: "$profile" was not found';
  }
}

class ProfileAlreadyExistsException with ErrorExceptionMixin {
  final String profile;
  const ProfileAlreadyExistsException(this.profile);

  @override
  String toString() {
    return 'ProfileAlreadyExistsException: "$profile" already exists';
  }
}

class ActiveProfileRemovalException with ErrorExceptionMixin {
  final String profile;
  const ActiveProfileRemovalException(this.profile);

  @override
  String toString() {
    return 'ActiveProfileRemovalException: "$profile" can\'t be removed as it is in use';
  }
}
