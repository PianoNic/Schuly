using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Schuly.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class RemoveOAuthFields : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "GoogleOAuthId",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "MicrosoftOAuthId",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "OAuthLinkedAt",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "OAuthProviderId",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "OAuthProviderType",
                table: "Users");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "GoogleOAuthId",
                table: "Users",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "MicrosoftOAuthId",
                table: "Users",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "OAuthLinkedAt",
                table: "Users",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "OAuthProviderId",
                table: "Users",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "OAuthProviderType",
                table: "Users",
                type: "text",
                nullable: true);
        }
    }
}
