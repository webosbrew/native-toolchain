file(GLOB BINARIES RELATIVE ${BINDIR} "${BINDIR}/*.br_real")

foreach (BINARY ${BINARIES})
    string(REPLACE ".br_real" "" ORIGINAL "${BINARY}")
    file(CREATE_LINK "toolchain-wrapper" "${BINDIR}/${ORIGINAL}" SYMBOLIC)
endforeach ()