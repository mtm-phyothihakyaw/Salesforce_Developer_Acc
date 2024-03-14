public with sharing class RunScheduler implements Schedulable {
    public static String scheduleTime{get; set;}
    public static Scheduler_Time__c record {get; set;}

    public static void execute(SchedulableContext sc) {
        if (record != null) {
            scheduleTime = getScheduleTime();
            System.debug('scheduleTime: ' + scheduleTime);
        }
    }

    public static String getScheduleTime() {
        DateTime dt = record.Schedule_Date_Time__c;
        String hour = String.valueOf(dt.hour());
        String minute = String.valueOf(dt.minute());
        String second = String.valueOf(dt.second());
        String month = String.valueOf(dt.month());
        String year = String.valueOf(dt.year());
        String day = String.valueOf(dt.day());
        String daily = record.Run_Daily__c ? '*' : day;
        String weekly = record.Run_Weekly__c ? '*' : '?';
        String monthly = record.Run_Monthly__c ? '*' : month;
        String CronExpression = second + ' ' + minute + ' ' + hour + ' ' + daily + ' ' + monthly + ' ' + weekly + ' ' + year;
        return CronExpression;
    }

    public static CronTrigger getJob() {
        String jobName = record.Name;
        List<CronJobDetail> jobDetail =  [SELECT Id, Name FROM CronJobDetail WHERE Name =:jobName];
        if (jobDetail.size() == 0) {
            return null;
        }
        return [SELECT Id, CronExpression, CronJobDetailId, NextFireTime FROM CronTrigger WHERE CronJobDetailId = :jobDetail[0].Id];
    }
}