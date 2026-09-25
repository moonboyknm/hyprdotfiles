import sys
from datetime import datetime, timedelta


def calculate_time_left(user_input=None):
  """Print the time remaining until ``user_input`` (or prompt for it)."""
  if user_input is None:
    user_input = input("Enter target time (e.g., 14:30 or 2:30 PM): ").strip()

  now = datetime.now()
  target_time = None

  # Try parsing 24-hour format (HH:MM) first, then 12-hour format (I:M PM/AM)
  for fmt in ("%H:%M", "%I:%M %p", "%I %p"):
    try:
      parsed_time = datetime.strptime(user_input, fmt)
      # Combine today's date with the entered time
      target_time = now.replace(
          hour=parsed_time.hour,
          minute=parsed_time.minute,
          second=0,
          microsecond=0,
      )
      break
    except ValueError:
      continue

  if not target_time:
    print(
        "Invalid format! Please use formats like 14:30, 2:30 PM, or 5 PM."
    )
    return

  # If the target time has already passed today, assume it's for tomorrow
  if target_time <= now:
    target_time += timedelta(days=1)

  # Calculate difference
  difference = target_time - now
  total_seconds = int(difference.total_seconds())

  hours = total_seconds // 3600
  minutes = (total_seconds % 3600) // 60

  print(
      f"Current time: {now.strftime('%I:%M %p')}"
  )
  print(
      f"Target time: {target_time.strftime('%I:%M %p')} "
      f"{'(Tomorrow)' if target_time.day != now.day else ''}"
  )
  print(
      f"⏱️ There are **{hours} hours and {minutes} minutes** left until your"
      " target time."
  )


if __name__ == "__main__":
  # Join arguments so both `hoursleft 01:00` and `hoursleft 1 AM` work.
  calculate_time_left(" ".join(sys.argv[1:]) or None)
