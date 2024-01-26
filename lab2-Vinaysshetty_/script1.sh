echo "Enter a cell name:"
read user_input
#grep -c "\bcell (" /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib/stdcell_rvt/db_nldm/saed32rvt_ss0p75v125c.lib
#grep "\bcell (" /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib/stdcell_rvt/db_nldm/saed32rvt_ss0p75v125c.lib | grep "\bAND2"
grep "\bcell (" /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib/stdcell_rvt/db_nldm/saed32rvt_ss0p75v125c.lib | grep -c "\b$user_input"
egrep "\bcell |\bfunction " /pkgs/synopsys/2020/32_28nm/SAED32_EDK/lib/stdcell_rvt/db_nldm/saed32rvt_ss0p75v125c.lib | egrep -A1 "\b$user_input"
