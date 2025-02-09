﻿using Saas.Admin.Service.Controllers;

namespace Saas.Admin.Service.Services;

public interface ITenantService
{
    Task<IEnumerable<TenantDTO>> GetAllTenantsAsync();

    Task<TenantDTO> GetTenantAsync(Guid tenantId);
    Task<IEnumerable<TenantDTO>> GetTenantsByIdAsync(IEnumerable<string> ids);

    Task<TenantDTO> AddTenantAsync(NewTenantRequest newTenantRequest, string adminId);

    Task<TenantDTO> UpdateTenantAsync(TenantDTO tenant);

    Task DeleteTenantAsync(Guid tenantId);

    Task<bool> TenantExistsAsync(Guid tenantId);
    Task<bool> CheckPathExists(string path);
}
