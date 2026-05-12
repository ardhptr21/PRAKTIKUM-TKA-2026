#!/bin/bash

BASE_URL="http://localhost:5173"

LINKED_GATES=(
  "CHUNITHM"
  "CHUNITHM PLUS"
  "AIR"
  "STAR"
  "AMAZON"
  "CRYSTAL"
  "CRYSTAL PLUS"
  "PARADISE"
  "NEW"
  "SUN"
  "SUN PLUS"
  "LUMINOUS"
  "LUMINOUS PLUS"
  "VERSE"
  "X-VERSE"
  "RE:VERSE"
  "UNIVERSE"
)

random_gate() {
  echo "${LINKED_GATES[$RANDOM % ${#LINKED_GATES[@]}]}"
}

generate_player_id() {
  printf "P%03d" "$1"
}

generate_player_name() {
  printf "Player-%03d" "$1"
}

echo "[+] Generating Linked VERSE test events..."

# ==========================================
# 1. GATE ACCESS SUCCESS
# ==========================================
echo "[+] GENERATE GATE ACCESS SUCCESS EVENTS"

for i in {1..6}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/gate/access" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\"
  }" > /dev/null
done

# ==========================================
# 2. GATE UNLOCK FAILED
# ==========================================
echo "[+] GENERATE GATE UNLOCK FAILED EVENTS"

for i in {7..11}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/gate/unlock" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\",
    \"condition_met\": false
  }" > /dev/null
done

# ==========================================
# 3. GATE UNLOCK SUCCESS
# ==========================================
echo "[+] GENERATE GATE UNLOCK SUCCESS EVENTS"

for i in {12..16}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/gate/unlock" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\",
    \"condition_met\": true
  }" > /dev/null
done

# ==========================================
# 4. CHALLENGE START
# ==========================================
echo "[+] GENERATE CHALLENGE START EVENTS"

for i in {17..21}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/challenge/start" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\"
  }" > /dev/null
done

# ==========================================
# 5. CHALLENGE CLEAR
# ==========================================
echo "[+] GENERATE CHALLENGE CLEAR EVENTS"

for i in {22..26}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/challenge/result" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\",
    \"cleared\": true
  }" > /dev/null
done

# ==========================================
# 6. CHALLENGE FAILED
# ==========================================
echo "[+] GENERATE CHALLENGE FAILED EVENTS"

for i in {27..31}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/challenge/result" \
  -H "Content-Type: application/json" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"$(random_gate)\",
    \"cleared\": false
  }" > /dev/null
done

# ==========================================
# 7. INVALID GATE REQUEST
# ==========================================
echo "[+] GENERATE INVALID GATE REQUEST EVENTS"

SUSPICIOUS_IP="$((RANDOM % 223 + 1)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"

for i in {32..34}
do
PLAYER_ID=$(generate_player_id "$i")
PLAYER_NAME=$(generate_player_name "$i")

curl -s -X POST "$BASE_URL/gate/access" \
  -H "Content-Type: application/json" \
  -H "X-Forwarded-For: $SUSPICIOUS_IP" \
  -d "{
    \"player_id\":\"$PLAYER_ID\",
    \"player_name\":\"$PLAYER_NAME\",
    \"linked_gate\":\"HACKED_GATE_$i\"
  }" > /dev/null
done

# ==========================================
# 8. MALFORMED LOG
# ==========================================
echo "[+] GENERATE MALFORMED LOG EVENTS"

curl -s -X POST "$BASE_URL/debug/malformed-log" \
  -H "Content-Type: application/json" \
  -d '{}' > /dev/null

# ==========================================
# 9. MISSING FIELD LOG
# ==========================================
echo "[+] GENERATE MISSING FIELD LOG EVENTS"

curl -s -X POST "$BASE_URL/debug/missing-field-log" \
  -H "Content-Type: application/json" \
  -d '{}' > /dev/null

echo "[+] DONE GENERATING DUMMY EVENTS"