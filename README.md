# MMA Fight Analysis (Beta)

A SQL + Python-based fight breakdown tool designed to track MMA/UFC fights in detail. This beta version includes a sample dataset for Khamzat Chimaev vs Kevin Holland (UFC 279).

## 📊 Features

- SQL schema for Fighters, Fights, Rounds, and FightActions
- Per-round, per-action fight logging system
- Takedown and strike queries
- Graph generation for action breakdowns
- Easily extendable with new fights and fighters

## 🧪 Sample Use

```bash
# Set up the environment
pip install -r requirements.txt

# Build the database
sqlite3 data/fight_analysis.db < sql/schema.sql

# Run fight analysis
python scripts/analyze_fight.py
```

## 📁 Directory Structure

```
mma-fight-analysis-beta/
├── README.md
├── LICENSE
├── .gitignore
├── requirements.txt
├── data/
│   ├── Fighters.csv
│   ├── Fights.csv
│   ├── Rounds.csv
│   └── FightActions.csv
├── sql/
│   └── schema.sql
├── scripts/
│   └── analyze_fight.py
```

## 🗃️ Sample Data

This repo includes:
- Khamzat Chimaev vs Kevin Holland (UFC 279)
- Fight actions logged by time, round, and type

## 🚧 TODO

- Web dashboard UI
- Import/export automation
- ML predictions based on stat trends

## 📜 License

MIT License (see LICENSE file)
