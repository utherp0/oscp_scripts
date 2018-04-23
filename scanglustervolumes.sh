echo -e 'Name\t\t\t\t\tID\t\t\t\t\tStatus\t\tBrick 1\t\tBrick 2\t\tBrick 3'
for volume in `gluster volume info | grep 'Volume Name: ' | awk '{ print $3 }'`;
do
  VOLDESC=$(gluster volume info $volume)
  VOLNAME=$(echo $VOLDESC | awk '{ print $3 }');
  VOLID=$(echo $VOLDESC | awk '{ print $8 }');
  VOLSTATUS=$(echo $VOLDESC | awk '{ print $10 }');
  VOLBRICK1=$(echo $VOLDESC | awk '{ print $26 }' | awk -F ':' '{ print $1 }');
  VOLBRICK2=$(echo $VOLDESC | awk '{ print $28 }' | awk -F ':' '{ print $1 }');
  VOLBRICK3=$(echo $VOLDESC | awk '{ print $30 }' | awk -F ':' '{ print $1 }');
  echo -e "$VOLNAME\t$VOLID\t$VOLSTATUS\t\t$VOLBRICK1\t$VOLBRICK2\t$VOLBRICK3"
done
