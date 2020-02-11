class Functions {
    Functions._();

    /*
     * getTitleSlug(): Returns a string where the value is stripped of any non-alphanumeric, spaces replaced with dashes
     */
    static String getTitleSlug(String value) {
        return value
            .toLowerCase()
            .replaceAll(RegExp(r'[\ \.]'), '-')
            .replaceAll(RegExp(r'[^a-zA-Z0-9\-]'), '')
            .trim();
    }

    /*
     * toCapitalize(): Returns a string with the first letter of each word capitalized
     */
    static String toCapitalize(String words) {
        List<String> split = words.split(' ');
        for(var i=0; i<split.length; i++) {
            split[i] = split[i].substring(0, 1).toUpperCase()+split[i].substring(1);
        }
        return split.join(' ');
    }

    /*
     * daysDifferenceReadable(): Returns a string signifying the amount of days difference
     */
    static String daysDifferenceReadable(DateTime start, DateTime end) {
        Duration diff = end.difference(start);
        if(diff.inDays == 0) {
            return 'TODAY';
        } else if(diff.inDays > 30) {
            return '';
        } else {
            return 'IN ${diff.inDays} DAYS';
        }
    }

    /*
     * runtimeReadable(): Returns a string signifying the amount of time given an integer
     */ 
    static String runtimeReadable(int runtime, {bool withDot = false}) {
        double rt = runtime.toDouble();
        if(rt == 0) {
            return '';
        } else if(rt <= 60) {
            return withDot ? 
                '\t•\t${runtime}m' :
                '${runtime}m';
        } else if(rt <= 1440) {
            int hours = 0;
            while(rt > 60) {
                hours++;
                rt -= 60;
            }
            return withDot ?
                '\t•\t${hours}h ${rt.floor()}m' :
                '${hours}h ${rt.floor()}m';
        }
        return '';
    }

    /*
     * trackDurationReadable(): Returns a string signifying the duration of a track
     */
    static String trackDurationReadable(int duration) {
        int seconds = (duration/1000).floor();
        if(seconds >= 3600) {
            int hours = 0;
            int minutes = 0;
            while(seconds >= 3600) {
                seconds -= 3600;
                hours++;
            }
            while(seconds >= 60) {
                seconds -= 60;
                minutes++;
            }
            return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        } else {
            int minutes = 0;
            while(seconds >= 60) {
                seconds -= 60;
                minutes++;
            }
            return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        }
    }

    /*
     * secondsToTimestamp(): Returns a string signifying a timestamp
     */
    static String secondsToTimestamp(int duration) {
        if(duration >= 3600) {
            int hours = 0;
            int minutes = 0;
            while(duration >= 3600) {
                duration -= 3600;
                hours++;
            }
            while(duration >= 60) {
                duration -= 60;
                minutes++;
            }
            return '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${duration.toString().padLeft(2, '0')}';
        } else {
            int minutes = 0;
            while(duration >= 60) {
                duration -= 60;
                minutes++;
            }
            return '0:${minutes.toString().padLeft(2, '0')}:${duration.toString().padLeft(2, '0')}';
        }
    }

    static String secondsToString(int duration) {
        if(duration >= 60*60*24) {
            int days = (duration/(60*60*24)).floor();
            return days == 1 ? '1 Day' : '$days Days';
        } else if(duration >=  60*60) {
            int hours = (duration/(60*60)).floor();
            return hours == 1 ? '1 Hour' : '$hours Hours';
        } else if(duration >= 60) {
            int minutes = (duration/60).floor();
            return minutes == 1 ? '1 Minute' : '$minutes Minutes';
        } else {
            return duration == 1 ? '1 Second' : '$duration Seconds';
        }
    }

    /*
     * hoursReadable(): Returns a string signifying the amount of hours given a double
     */
    static String hoursReadable(double hours) {
        if(hours > 48) {
            int counter = 0;
            while(hours > 48) {
                counter++;
                hours -= 24;
            }
            return counter == 1 ? '1 Day Ago' : '$counter Days Ago';
        } else {
            return hours == 1 ? '1 Hour Ago' : '${hours.toStringAsFixed(1)} Hours Ago';
        }
    }

    /*
     * timestampDifference(): Returns a string signifying the amount of time between now and then
     */
    static String timestampDifference(DateTime now, DateTime date) {
        Duration difference = now.difference(date);
        if(difference.inDays >= 1) {
            return '${difference.inDays} ${difference.inDays == 1 ? 'Day' : 'Days'} Ago';
        } else if(difference.inHours >= 1) {
            return '${difference.inHours} ${difference.inHours == 1 ? 'Hour' : 'Hours'} Ago';
        } else if(difference.inMinutes >= 1) {
            return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'Minute' : 'Minutes'} Ago';
        }
        return '${difference.inSeconds} ${difference.inSeconds == 1 ? 'Second' : 'Seconds'} Ago';
    }
}