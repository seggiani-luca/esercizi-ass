define chk_mask
	continue
	x/8tw &flag
end

define qquit
set confirm off
quit
end
document qquit
Quit without asking for confirmation.
end

define rrun
set confirm off
run
set confirm on
end
document rrun
Re-run without asking for confirmation.
end

set pagination off

break compito_alt.s:25

run

set $i = 0

while $i < 50
	chk_mask

	set $i = $i + 1
end

qquit
