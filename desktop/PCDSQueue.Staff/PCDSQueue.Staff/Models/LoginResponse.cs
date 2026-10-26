using System.Text.Json.Serialization;

namespace PCDSQueue.Staff.Models;

public sealed class LoginResponse
{
    [JsonPropertyName("message")]
    public string Message { get; init; } = string.Empty;

    [JsonPropertyName("access_token")]
    public string AccessToken { get; init; } = string.Empty;

    [JsonPropertyName("user")]
    public UserModel? User { get; init; }
}

public sealed class UserModel
{
    [JsonPropertyName("staff_id")]
    public int StaffId { get; init; }

    [JsonPropertyName("full_name")]
    public string FullName { get; init; } = string.Empty;

    [JsonPropertyName("username")]
    public string Username { get; init; } = string.Empty;

    [JsonPropertyName("role")]
    public string Role { get; init; } = string.Empty;

    [JsonPropertyName("account_status")]
    public string AccountStatus { get; init; } = string.Empty;

    [JsonPropertyName("assignment")]
    public AssignmentModel? Assignment { get; init; }
}

public sealed class AssignmentModel
{
    [JsonPropertyName("department_id")]
    public int? DepartmentId { get; init; }

    [JsonPropertyName("department_name")]
    public string? DepartmentName { get; init; }

    [JsonPropertyName("queue_prefix")]
    public string? QueuePrefix { get; init; }

    [JsonPropertyName("window_id")]
    public int? WindowId { get; init; }

    [JsonPropertyName("window_number")]
    public int? WindowNumber { get; init; }

    [JsonPropertyName("window_name")]
    public string? WindowName { get; init; }
}
