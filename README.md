# SOQL
## 📘 Use Cases & Query Objectives

1. **Retrieve accounts that have more than 5 related contacts.**

2. **Find the top 3 accounts with the highest number of related opportunities.**

3. **Get all opportunities where:**
   - The account's industry is `'Technology'` AND  
   - The opportunity amount is above the account's annual revenue.

4. **List contacts related to accounts that have no opportunities.**

5. **Fetch opportunities that have not been updated in the last 60 days.**

6. **List accounts that do not have any contacts.**

7. **Get opportunities that were:**
   - Created in the last fiscal quarter AND  
   - Are not closed.

8. **Retrieve opportunities where:**
   - The account industry is `'Finance'` AND  
   - The opportunity owner's role contains `'Manager'`.

9. **Find leads created by users who have never created any opportunities.**

10. **Retrieve accounts with at least one closed-won opportunity over $100,000, and display:**
    - The account name  
    - The number of such opportunities

11. **Get contacts whose related account has more than one open case.**

12. **Find accounts with:**
    - No related cases AND  
    - No related opportunities.

13. **Retrieve the top 5 users who own the most opportunities with amount over $50,000.**

14. **Fetch opportunities where:**
    - The related account's last modified date is greater than the opportunity's last modified date.

15. **List opportunities:**
    - Created in the last 30 days AND  
    - Where the related account was created more than 1 year ago.

16. **Count the number of leads per lead source, filtering for sources with more than 10 leads.**

17. **Retrieve cases where:**
    - The related contact's account is in **California** AND  
    - The contact email ends with `.org`.

18. **List accounts where the number of contacts is greater than the number of opportunities.**

19. **Find contacts whose related accounts have:**
    - At least 3 open cases AND  
    - At least one closed-won opportunity.

## 🛠️ Technologies Used
- **Salesforce SOQL (Salesforce Object Query Language)**
- **Standard Salesforce Objects**: `Account`, `Contact`, `Opportunity`, `Lead`, `User`, `Case`
