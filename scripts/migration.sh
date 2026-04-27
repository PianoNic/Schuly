#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT="$SCRIPT_DIR/../src/Schuly.Infrastructure"
STARTUP="$SCRIPT_DIR/../src/Schuly.API"
COMMAND="${1:-}"

usage() {
    echo "Usage:"
    echo "  ./migration.sh add <Name>    Add a new migration"
    echo "  ./migration.sh remove        Remove the last migration"
    echo "  ./migration.sh list          List all migrations"
    echo "  ./migration.sh update [Name] Apply migrations (optionally to a specific one)"
    echo "  ./migration.sh drop          Drop the database"
}

case "$COMMAND" in
    add)
        if [ -z "${2:-}" ]; then
            echo "Error: migration name required." >&2
            echo "Example: ./migration.sh add InitialCreate" >&2
            exit 1
        fi
        dotnet ef migrations add "$2" --project "$PROJECT" --startup-project "$STARTUP"
        ;;
    remove)
        dotnet ef migrations remove --project "$PROJECT" --startup-project "$STARTUP"
        ;;
    list)
        dotnet ef migrations list --project "$PROJECT" --startup-project "$STARTUP"
        ;;
    update)
        if [ -n "${2:-}" ]; then
            dotnet ef database update "$2" --project "$PROJECT" --startup-project "$STARTUP"
        else
            dotnet ef database update --project "$PROJECT" --startup-project "$STARTUP"
        fi
        ;;
    drop)
        dotnet ef database drop --project "$PROJECT" --startup-project "$STARTUP"
        ;;
    "")
        usage
        exit 1
        ;;
    *)
        usage
        exit 1
        ;;
esac
