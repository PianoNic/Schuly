using Mediator;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Schuly.Application.Commands.User;
using Schuly.Application.Queries.User;
using Schuly.Application.Services.Interfaces;

namespace Schuly.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IMediator _mediator;
        private readonly ITwoFactorService _twoFactorService;

        public AuthController(IMediator mediator, ITwoFactorService twoFactorService)
        {
            _mediator = mediator;
            _twoFactorService = twoFactorService;
        }

        [HttpPost("register")]
        [AllowAnonymous]
        public async Task<ActionResult<RegisterResponse>> Register([FromBody] RegisterCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("login")]
        [AllowAnonymous]
        public async Task<ActionResult<LoginResponse>> Login([FromBody] LoginCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success && !result.RequiresTwoFactor)
            {
                return Unauthorized(result);
            }

            return Ok(result);
        }

        [HttpPost("verify-2fa")]
        [AllowAnonymous]
        public async Task<ActionResult<VerifyTwoFactorResponse>> VerifyTwoFactor([FromBody] VerifyTwoFactorCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return Unauthorized(result);
            }

            return Ok(result);
        }

        [HttpPost("enable-2fa")]
        [Authorize]
        public async Task<ActionResult<EnableTwoFactorResponse>> EnableTwoFactor()
        {
            var result = await _mediator.Send(new EnableTwoFactorCommand());

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpGet("2fa-qr-code")]
        [Authorize]
        public async Task<ActionResult> GetTwoFactorQrCode()
        {
            var enableResult = await _mediator.Send(new EnableTwoFactorCommand());

            if (!enableResult.Success || string.IsNullOrEmpty(enableResult.QrCodeUri))
            {
                return BadRequest(enableResult);
            }

            var pngData = _twoFactorService.GenerateQrCodePng(enableResult.QrCodeUri);
            return File(pngData, "image/png", "2fa-qr-code.png");
        }

        [HttpPost("confirm-2fa-setup")]
        [Authorize]
        public async Task<ActionResult<ConfirmTwoFactorSetupResponse>> ConfirmTwoFactorSetup([FromBody] ConfirmTwoFactorSetupCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpPost("disable-2fa")]
        [Authorize]
        public async Task<ActionResult<DisableTwoFactorResponse>> DisableTwoFactor([FromBody] DisableTwoFactorCommand command)
        {
            var result = await _mediator.Send(command);

            if (!result.Success)
            {
                return BadRequest(result);
            }

            return Ok(result);
        }

        [HttpGet("2fa-status")]
        [Authorize]
        public async Task<ActionResult<TwoFactorStatusDto>> GetTwoFactorStatus()
        {
            var result = await _mediator.Send(new GetTwoFactorStatusQuery());

            return Ok(result);
        }

        [HttpGet("me")]
        [Authorize]
        public async Task<ActionResult<GetCurrentUserQuery>> GetCurrentUser()
        {
            var result = await _mediator.Send(new GetCurrentUserQuery());

            if (result == null)
            {
                return Unauthorized();
            }

            return Ok(result);
        }
    }
}
