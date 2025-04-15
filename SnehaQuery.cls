public with sharing class SnehaQuery {
    //Retrieve accounts that have more than 5 related contacts.
    public List<Account> AccountsWithRelatedContacts(){
        AggregateResult[] accounts = [SELECT count(id) FROM Contact GROUP BY AccountId HAVING Count(id) > 5];
        return accounts;
    }
    //Find the top 3 accounts with the highest number of related opportunities.
    public List<Opportunity> HighestOpportunityPerAccount(){
        AggregateResult[] Opportunity = [SELECT count(id),accountid FROM Opportunity GROUP BY Accountid order by  count(id) DESC LIMIT 3];
        return Opportunity;
    }
    //Get all opportunities where the account's industry is 'Technology' AND the opportunity amount is above the account's annual revenue.
    public List<Opportunity> OpportunityTechnology(){
        AggregateResult[] opp = [SELECT id,Account.Name FROM Opportunity WHERE Account.Industry ='Technology'];
        List<Opportunity> op = new List<Opportunity>();
        for(Opportunity o : opp){
            if(o.Amount < o.Account.AnnualRevenue){
                op.add(o);
            }
        }
        return op;
    }
    //List contacts who are related to accounts that have no opportunities.
    public List<Contact> lstOfContact(){
        AggregateResult[] con = [SELECT accountId,id,name From Contact Where Accountid NOT in (SELECT accountid From Opportunity)];
        return con;
    }
    //Fetch opportunities that have not been updated in the last 60 days.
    public List<Opportunity> lstOfOpportunityNotUpdate(){
        AggregateResult[] opp = [SELECT id,Name FROM Opportunity WHERE LastActivityDate < LAST_N_DAYS:60];
        return opp;
    }
    //List accounts that do not have any contacts.
    public List<Account> lstOfAccountsWithNoContact(){
        AggregateResult[] acc =[SELECT id FROM Account where id not in (SELECT AccountID FROM contact)]
        return acc;
    }
    //Get opportunities that were created in the last fiscal quarter and are not closed.
    public List<Opportunity> lstOfOpp(){
        AggregateResult[] opps =[SELECT name FROM Opportunity WHERE CreatedDate >=LAST_FISCAL_QUARTER  and StageName Not in ('Closed Won','Closed Lost')];
        return opps;
    }
    //Retrieve opportunities where both the account industry is 'Finance' AND the owner’s role contains 'Manager'.
    public List<Opportunity> lstOfManagerRole(){
        List<Opportunity> op = [SELECT id,Name,Owner.UserRole.Name FROM Opportunity WHERE Account.Industry ='Finance'];
        List<Opportunity> newop = new List<Opportunity>();
        for(Opportunity o:op){
            if(o.Owner.UserRole.Name.contains('Manager')){
                newop.add(o);
            }
        }
    }
    //Find leads that were created by users who have never created any opportunities.
    public List<Lead> lstOfLeads(){
        Set<Id> oppCreatorIds = new Set<Id>();
        for (AggregateResult ar : [SELECT CreatedById FROM Opportunity GROUP BY CreatedById]) {
            oppCreatorIds.add((Id) ar.get('CreatedById'));
        }
        List<Lead> leads = [
            SELECT Id, Name, CreatedBy.Name 
            FROM Lead 
            WHERE CreatedById NOT IN :oppCreatorIds
        ];
    }
    //Retrieve accounts with at least one closed-won opportunity above $100,000, and show the account name and number of such opportunities.
    public List<Opportunity> lstOfOpp(){
        AggregateResult[] opp = [SELECT Account.Name,Count(id) From Opportunity where StageName = 'Closed Won' and Amount > 100000 GROUP BY Account.Name Having count(ID) >=1];
        return opp;
    }
    //Get contacts whose related account has more than one open case.
    public List<Contact> lstOfContactHasMoreCase(){
        Set<Id> accIDs = new Set<Id>();
        AggregateResult[] con = [SELECT AccountId FROM Case WHERE Status = 'Open' GROUP BY AccountId HAVING COUNT(Id) > 1]
        for(Case c:con){
            c.add((Id) c.get('AccountId'));
        }
        List<Contact> contacts = [SELECT id,Name,AccountId FROM Contact where AccountId In :accIDs];
        return contacts;
    }
    //Find accounts with no related cases AND no related opportunities.
    public List<Account> lstOfAccountNotRelatedCase(){
        AggregateResult[] ac = [SELECT id,Name FROM Account Where id Not in (Select AccountId FROM Case) AND id NOT IN (SELECT AccountId FROM Opportunity)];
        return ac;
    }
    //Retrieve top 5 users who own the most opportunities with amount over $50,000.
    public List<Opportunity> lstOfFiveTopUser(){
        AggregateResult[] user = [SELECT OwnerId, COUNT(Id) FROM Opportunity WHERE Amount > 50000 GROUP BY OwnerId ORDER BY COUNT(Id) DESC LIMIT 5];
        return user;
    }
    //Fetch opportunities where the related account's last modified date is greater than the opportunity's last modified date.
    public List<Opportunity> lstOfOppBasedOnLastModifiedDate(){
        List<Opportunity> opp = [SELECT id,LastModifiedDate,Account.LastModifiedDate From Opportunity Where AccountId != Null];
        List<Opportunity> newOpp = new List<Opportunity>();
        for(Opportunity o:opp){
            if(o.LastModifiedDate > o.Account.LastModifiedDate){
                newOpp.add(o);
            }
        }
        return newOpp;
    }
    //List opportunities created in the last 30 days and where the account was created more than 1 year ago.
    public List<Opportunity> lstOfOpportunityCreatedBEforeLastYear(){
        AggregateResult[] op = [Select CreatedDate FROM Opportunity WHERE CreatedDate  = LAST_N_DAYS:30 and Account.CreatedDate < LAST_YEAR ];
        return op;
    }
    //Count the number of leads created per lead source, but only include sources with more than 10 leads.
    public List<Lead> lstOfLeadsBasedOnLeadSource(){
        AggregateResult[] lead = [SELECT LeadSource, COUNT(id) FROM Lead GROUP BY LeadSource HAVING COUNT(id) > 10];
        return lead;
    }
    //Retrieve cases where the related contact’s account is in California AND the contact email ends with 'org'.
    public List<Case> lstOfCaseWhereCaliforniaBilingCity(){
        List<Case> cases = [SELECT Contact.Email FROM Case WHERE Contact.Email Like '%org' and Contact.Account.BillingCity ='California'];
        return cases;
    }
    //List accounts where the number of contacts > number of opportunities.
    public List<Account> lstOfAccount(){
        AggregateResult[] res = [SELECT AccountId,Count(id) FROM Case Where Status ='New' GROUP BY AccountId Having COUNT(id)>3];
        return res;
    }
    //Get opportunities that were created by users whose profile name is 'Sales Rep', and the opportunity stage is ‘Negotiation/Review’.
    public List<Opportunity> lstOfOpp(){
        AggregateResult[] opp = [SELECT id FROM Opportunity where StageName ='Negotiation/Review' and CreatedBy.Profile.Name = 'Sales Rep'];
        return opp;
    }
}