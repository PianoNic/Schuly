// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_task_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PluginTaskStatus extends PluginTaskStatus {
  @override
  final String? name;
  @override
  final double? intervalSeconds;
  @override
  final String? lastStatus;
  @override
  final DateTime? lastStartedAt;
  @override
  final DateTime? lastFinishedAt;
  @override
  final int? lastDurationMs;
  @override
  final String? lastError;
  @override
  final DateTime? nextRunAt;
  @override
  final int? totalRuns;
  @override
  final int? totalFailures;
  @override
  final int? consecutiveFailures;

  factory _$PluginTaskStatus([
    void Function(PluginTaskStatusBuilder)? updates,
  ]) => (PluginTaskStatusBuilder()..update(updates))._build();

  _$PluginTaskStatus._({
    this.name,
    this.intervalSeconds,
    this.lastStatus,
    this.lastStartedAt,
    this.lastFinishedAt,
    this.lastDurationMs,
    this.lastError,
    this.nextRunAt,
    this.totalRuns,
    this.totalFailures,
    this.consecutiveFailures,
  }) : super._();
  @override
  PluginTaskStatus rebuild(void Function(PluginTaskStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PluginTaskStatusBuilder toBuilder() =>
      PluginTaskStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PluginTaskStatus &&
        name == other.name &&
        intervalSeconds == other.intervalSeconds &&
        lastStatus == other.lastStatus &&
        lastStartedAt == other.lastStartedAt &&
        lastFinishedAt == other.lastFinishedAt &&
        lastDurationMs == other.lastDurationMs &&
        lastError == other.lastError &&
        nextRunAt == other.nextRunAt &&
        totalRuns == other.totalRuns &&
        totalFailures == other.totalFailures &&
        consecutiveFailures == other.consecutiveFailures;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, intervalSeconds.hashCode);
    _$hash = $jc(_$hash, lastStatus.hashCode);
    _$hash = $jc(_$hash, lastStartedAt.hashCode);
    _$hash = $jc(_$hash, lastFinishedAt.hashCode);
    _$hash = $jc(_$hash, lastDurationMs.hashCode);
    _$hash = $jc(_$hash, lastError.hashCode);
    _$hash = $jc(_$hash, nextRunAt.hashCode);
    _$hash = $jc(_$hash, totalRuns.hashCode);
    _$hash = $jc(_$hash, totalFailures.hashCode);
    _$hash = $jc(_$hash, consecutiveFailures.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PluginTaskStatus')
          ..add('name', name)
          ..add('intervalSeconds', intervalSeconds)
          ..add('lastStatus', lastStatus)
          ..add('lastStartedAt', lastStartedAt)
          ..add('lastFinishedAt', lastFinishedAt)
          ..add('lastDurationMs', lastDurationMs)
          ..add('lastError', lastError)
          ..add('nextRunAt', nextRunAt)
          ..add('totalRuns', totalRuns)
          ..add('totalFailures', totalFailures)
          ..add('consecutiveFailures', consecutiveFailures))
        .toString();
  }
}

class PluginTaskStatusBuilder
    implements Builder<PluginTaskStatus, PluginTaskStatusBuilder> {
  _$PluginTaskStatus? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  double? _intervalSeconds;
  double? get intervalSeconds => _$this._intervalSeconds;
  set intervalSeconds(double? intervalSeconds) =>
      _$this._intervalSeconds = intervalSeconds;

  String? _lastStatus;
  String? get lastStatus => _$this._lastStatus;
  set lastStatus(String? lastStatus) => _$this._lastStatus = lastStatus;

  DateTime? _lastStartedAt;
  DateTime? get lastStartedAt => _$this._lastStartedAt;
  set lastStartedAt(DateTime? lastStartedAt) =>
      _$this._lastStartedAt = lastStartedAt;

  DateTime? _lastFinishedAt;
  DateTime? get lastFinishedAt => _$this._lastFinishedAt;
  set lastFinishedAt(DateTime? lastFinishedAt) =>
      _$this._lastFinishedAt = lastFinishedAt;

  int? _lastDurationMs;
  int? get lastDurationMs => _$this._lastDurationMs;
  set lastDurationMs(int? lastDurationMs) =>
      _$this._lastDurationMs = lastDurationMs;

  String? _lastError;
  String? get lastError => _$this._lastError;
  set lastError(String? lastError) => _$this._lastError = lastError;

  DateTime? _nextRunAt;
  DateTime? get nextRunAt => _$this._nextRunAt;
  set nextRunAt(DateTime? nextRunAt) => _$this._nextRunAt = nextRunAt;

  int? _totalRuns;
  int? get totalRuns => _$this._totalRuns;
  set totalRuns(int? totalRuns) => _$this._totalRuns = totalRuns;

  int? _totalFailures;
  int? get totalFailures => _$this._totalFailures;
  set totalFailures(int? totalFailures) =>
      _$this._totalFailures = totalFailures;

  int? _consecutiveFailures;
  int? get consecutiveFailures => _$this._consecutiveFailures;
  set consecutiveFailures(int? consecutiveFailures) =>
      _$this._consecutiveFailures = consecutiveFailures;

  PluginTaskStatusBuilder() {
    PluginTaskStatus._defaults(this);
  }

  PluginTaskStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _intervalSeconds = $v.intervalSeconds;
      _lastStatus = $v.lastStatus;
      _lastStartedAt = $v.lastStartedAt;
      _lastFinishedAt = $v.lastFinishedAt;
      _lastDurationMs = $v.lastDurationMs;
      _lastError = $v.lastError;
      _nextRunAt = $v.nextRunAt;
      _totalRuns = $v.totalRuns;
      _totalFailures = $v.totalFailures;
      _consecutiveFailures = $v.consecutiveFailures;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PluginTaskStatus other) {
    _$v = other as _$PluginTaskStatus;
  }

  @override
  void update(void Function(PluginTaskStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PluginTaskStatus build() => _build();

  _$PluginTaskStatus _build() {
    final _$result =
        _$v ??
        _$PluginTaskStatus._(
          name: name,
          intervalSeconds: intervalSeconds,
          lastStatus: lastStatus,
          lastStartedAt: lastStartedAt,
          lastFinishedAt: lastFinishedAt,
          lastDurationMs: lastDurationMs,
          lastError: lastError,
          nextRunAt: nextRunAt,
          totalRuns: totalRuns,
          totalFailures: totalFailures,
          consecutiveFailures: consecutiveFailures,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
