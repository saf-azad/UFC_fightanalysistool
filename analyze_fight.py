
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# Connect to the local database
conn = sqlite3.connect('../data/fight_analysis.db')

def get_takedown_attempts(fighter_name, round_number):
    query = """
    SELECT COUNT(*) as TakedownAttempts
    FROM FightActions fa
    JOIN Fighters f ON fa.FighterID = f.FighterID
    JOIN Rounds r ON fa.RoundID = r.RoundID
    WHERE f.Name = ?
      AND fa.ActionType = 'Takedown'
      AND r.RoundNumber = ?
    """
    df = pd.read_sql_query(query, conn, params=(fighter_name, round_number))
    return df

def plot_action_types_by_round(fighter_name, fight_id):
    query = """
    SELECT r.RoundNumber, fa.ActionType, COUNT(*) as ActionCount
    FROM FightActions fa
    JOIN Fighters f ON fa.FighterID = f.FighterID
    JOIN Rounds r ON fa.RoundID = r.RoundID
    WHERE f.Name = ?
      AND fa.FightID = ?
    GROUP BY r.RoundNumber, fa.ActionType
    ORDER BY r.RoundNumber, ActionCount DESC
    """
    df = pd.read_sql_query(query, conn, params=(fighter_name, fight_id))

    if df.empty:
        print("No data found.")
        return

    pivot_df = df.pivot(index='RoundNumber', columns='ActionType', values='ActionCount').fillna(0)
    pivot_df.plot(kind='bar', stacked=True, figsize=(10, 6))
    plt.title(f"Actions per Round: {fighter_name} (Fight {fight_id})")
    plt.xlabel("Round Number")
    plt.ylabel("Number of Actions")
    plt.legend(title="Action Type")
    plt.grid(True)
    plt.tight_layout()
    plt.show()

if __name__ == '__main__':
    print("Takedowns by Khamzat in Round 5:")
    print(get_takedown_attempts("Khamzat Chimaev", 5))

    print("\nGenerating action chart for UFC 300 fight (ID 1):")
    plot_action_types_by_round("Khamzat Chimaev", 1)

    print("\nGenerating action chart for UFC 279 fight (ID 2):")
    plot_action_types_by_round("Khamzat Chimaev", 2)

conn.close()
