# Systems Manager Patch Management for a Fleet of 50 Instances

Centralized patch management of EC2 instances using AWS Systems Manager Patch Manager.

## Problem
Manually patching 50 servers is time-consuming, hard to track, and leaves
security vulnerabilities when patches are missed.

## Solution
Use AWS Systems Manager Patch Manager to scan, install, schedule, and
monitor patches across all EC2 instances from one place.

## Architecture
EC2 Instances (tag: Patch Group = Fleet50) → Systems Manager → Patch Baseline
→ Scan → Install → Compliance Report → Maintenance Window (scheduled)

## Services Used
- Amazon EC2
- AWS Systems Manager (Fleet Manager, Patch Manager, Run Command, Maintenance Windows)
- AWS IAM

## Implementation Steps
1. Created IAM role `SSM-Patch-EC2-Role` with `AmazonSSMManagedInstanceCore`
2. Created security group with no inbound rules (no SSH exposure)
3. Created launch template with tags `Patch Group = Fleet50`
4. Launched instances in us-east-1
5. Verified nodes Online in Fleet Manager
6. Created patch baseline `Fleet50-Baseline` (Security, Bugfix; Critical, Important)
7. Linked baseline to patch group `Fleet50`
8. Ran Scan, then Scan and Install via Patch now
9. Created maintenance window `Fleet50-Patch-Window`
   (cron(0 2 ? * SUN *), Asia/Kolkata) with `AWS-RunPatchBaseline` task
10. Monitored via Compliance reporting and Run Command history

## Screenshots
![Fleet Manager](screenshots/02-fleet-manager-online.png)
![Compliance](screenshots/04-compliance-report.png)
![Maintenance Window](screenshots/06-maintenance-window.png)

## Results
- 3 demo instances managed centrally, all Online
- Scan and install commands completed successfully
- Automatic weekly patching scheduled

## Benefits
Time saving, better security, automation, centralized monitoring, less manual work.

## Note
Demo used 3 instances. The same setup scales to 50 since targeting is tag-based.