#!/usr/bin/env bash

counter=0

increase_counter() {
    (( counter++ ))
}

test_result() {
    local test_fixture="${1}"
    local expected_value="${2}"
    local received_value="${3}"
    if [[ "${received_value}" -eq "${expected_value}" ]] ; then 
        echo "${test_fixture} Passed"
    else
        echo "${test_fixture} Failed - expected ${expected_value} but received ${received_value}"
        increase_counter
    fi
}

test_fixture() {
	local file="${1}"
	local name="${2}"
	local expected="${3}"
    local result
    result=$(vale --output=line ${file} | wc -l)
    test_result "${name}" "${expected}" "${result}"
}


# Test Fixtures
test_fixture "tests/English/Acronyms.md" "Acronym Definitions" "2"
test_fixture "tests/English/Contractions.md" "Contractions" "23"
test_fixture "tests/English/Ellipses.md" "Ellipses" "1"
test_fixture "tests/English/OxfordComma.md" "Oxford Comma" "3"
test_fixture "tests/English/SentenceLength.md" "Sentence Length" "2"


# Result
echo ""
if [[ "${counter}" -gt 0 ]]; then
	echo "Tests failed with ${counter} errors"
else
    echo "All tests passed"
fi
