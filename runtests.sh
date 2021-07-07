#!/usr/bin/env bash

counter=0

print_header() {
    local title="$1"
    echo ""
    echo "==================================="
    echo "${title}"
    echo "==================================="
}

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
	local name="${1}"
	local path="${2}"
	local expected="${3}"
    local result
    result=$(vale --output=line --config="${path}/.vale.ini" "${path}/fixture.md" | wc -l)
    test_result "${name}" "${expected}" "${result}"
}


# Test Fixtures
print_header "English"
test_fixture "Acronym Definitions" "tests/English/Acronyms" "2"
test_fixture "Auto Hyphenation" "tests/English/Auto" "1"
test_fixture "Annotations" "tests/English/Annotations" "6"
test_fixture "But as a sentence start" "tests/English/But" "1"
test_fixture "Contractions" "tests/English/Contractions" "23"
test_fixture "Cursing" "tests/English/Cursing" "12"
test_fixture "Currency (Euros only)" "tests/English/Currency" "2"
test_fixture "Ellipses" "tests/English/Ellipses" "1"
test_fixture "Hyperbole" "tests/English/Hyperbole" "1"
test_fixture "Oxford Comma" "tests/English/OxfordComma" "3"
test_fixture "Sentence Length" "tests/English/SentenceLength" "2"
test_fixture "There Is" "tests/English/ThereIs" "2"
test_fixture "Weasel" "tests/English/Weasel" "203"


# Result
print_header "Result"
if [[ "${counter}" -gt 0 ]]; then
	echo "Tests failed with ${counter} errors"
else
    echo "All tests passed"
fi
