
create or replace resource teammonitor with credit_quota=5000
  notify_users = ("kiranmai.nandikonda@ascendion.com")
  triggers on 75 percent do notify
           on 100 percent do suspend
           on 110 percent do suspend_immediate
