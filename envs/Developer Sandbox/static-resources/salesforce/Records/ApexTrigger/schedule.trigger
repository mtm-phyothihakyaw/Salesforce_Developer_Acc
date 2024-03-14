trigger schedule on Scheduler_Time__c  (before insert, before update) {
    for(Scheduler_Time__c s : Trigger.new){
        if (s.Schedule_Date_Time__c != null){
            RunScheduler rs = new RunScheduler();
            RunScheduler.record = s;
            CronTrigger job = RunScheduler.getJob();
            if (job != null) {
                System.abortJob(job.Id);
                System.debug('Job aborted');
            }
            String CRON_EXP = RunScheduler.getScheduleTime();
            System.debug('CRON_EXP: ' + CRON_EXP);
            System.schedule(s.Name, CRON_EXP, rs);
        }

    }
}