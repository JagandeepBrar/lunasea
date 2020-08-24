extension DurationExtension on Duration {
    //ignore: non_constant_identifier_names
    String lsDuration_timestamp() {
        String hours = this.inHours.toString().padLeft(2, '0');
        String minutes = (this.inMinutes%60).toString().padLeft(2, '0');
        String seconds = (this.inSeconds%60).toString().padLeft(2, '0');
        return [
            if(hours != '00') '$hours:',
            '$minutes:',
            '$seconds',
        ].join();
    }
}
