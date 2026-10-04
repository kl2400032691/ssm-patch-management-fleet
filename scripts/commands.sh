# Scan patch group
aws ssm send-command \
  --document-name "AWS-RunPatchBaseline" \
  --targets "Key=tag:Patch Group,Values=Fleet50" \
  --parameters "Operation=Scan" \
  --region us-east-1

# Install patches
aws ssm send-command \
  --document-name "AWS-RunPatchBaseline" \
  --targets "Key=tag:Patch Group,Values=Fleet50" \
  --parameters "Operation=Install,RebootOption=RebootIfNeeded" \
  --region us-east-1