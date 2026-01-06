import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/utils/log_storage.dart';

/// Debug Console Widget
/// Logları gösterir, filtreleme ve temizleme özellikleri vardır
class DebugConsoleWidget extends StatefulWidget {
  const DebugConsoleWidget({super.key});

  @override
  State<DebugConsoleWidget> createState() => _DebugConsoleWidgetState();
}

class _DebugConsoleWidgetState extends State<DebugConsoleWidget> {
  final _logStorage = LogStorage();
  LogLevel? _selectedFilter;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<LogEntry> get _filteredLogs {
    if (_selectedFilter == null) {
      return _logStorage.logs;
    }
    return _logStorage.getLogsByLevel(_selectedFilter!);
  }

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.grey;
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.fatal:
        return Colors.purple;
      case LogLevel.network:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text(
                  '🐛 Debug Console',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text('${_filteredLogs.length} logs', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _logStorage.clear();
                    });
                  },
                  tooltip: 'Clear logs',
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Filter chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[850],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _selectedFilter == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = null;
                      });
                    },
                    selectedColor: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  ...LogLevel.values.map((level) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text('${level.emoji} ${level.name}'),
                        selected: _selectedFilter == level,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = selected ? level : null;
                          });
                        },
                        selectedColor: _getLevelColor(level),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Log list
          Expanded(
            child: _filteredLogs.isEmpty
                ? const Center(
                    child: Text('No logs available', style: TextStyle(color: Colors.white70)),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: _filteredLogs.length,
                    itemBuilder: (context, index) {
                      final log = _filteredLogs[index];
                      return _LogTile(
                        log: log,
                        onTap: log.level == LogLevel.network ? () => _showNetworkDetails(context, log) : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showNetworkDetails(BuildContext context, LogEntry log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NetworkDetailsModal(log: log),
    );
  }
}

/// Log tile widget
class _LogTile extends StatelessWidget {
  final LogEntry log;
  final VoidCallback? onTap;

  const _LogTile({required this.log, this.onTap});

  Color _getLevelColor(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return Colors.grey;
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.network:
        return Colors.teal;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.error:
        return Colors.red;
      case LogLevel.fatal:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          border: Border(left: BorderSide(color: _getLevelColor(log.level), width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(log.level.emoji, style: const TextStyle(fontSize: 16)),
                const SizedBox(width: 8),
                Text(
                  log.level.name,
                  style: TextStyle(color: _getLevelColor(log.level), fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(width: 8),
                Text(
                  '${log.timestamp.hour.toString().padLeft(2, '0')}:'
                  '${log.timestamp.minute.toString().padLeft(2, '0')}:'
                  '${log.timestamp.second.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
                if (log.duration != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    '${log.duration!.inMilliseconds}ms',
                    style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
                if (log.statusCode != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getStatusColor(log.statusCode!),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${log.statusCode}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                if (onTap != null) const Spacer(),
                if (onTap != null) const Icon(Icons.chevron_right, color: Colors.white38, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            // Message
            Text(log.message, style: const TextStyle(color: Colors.white, fontSize: 13)),
            // Error (if any)
            if (log.error != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'Error: ${log.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return Colors.green;
    } else if (statusCode >= 300 && statusCode < 400) {
      return Colors.blue;
    } else if (statusCode >= 400 && statusCode < 500) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

/// Network details modal
class _NetworkDetailsModal extends StatelessWidget {
  final LogEntry log;

  const _NetworkDetailsModal({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text(
                  '🌐 Network Details',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Method & URL
                  _SectionTitle('Request'),
                  _InfoRow('Method', log.method ?? 'N/A'),
                  _InfoRow('URL', log.url ?? 'N/A'),
                  if (log.duration != null) _InfoRow('Duration', '${log.duration!.inMilliseconds}ms'),
                  if (log.statusCode != null) _InfoRow('Status Code', '${log.statusCode}'),

                  const SizedBox(height: 16),

                  // Request Headers
                  if (log.requestHeaders != null && log.requestHeaders!.isNotEmpty) ...[
                    _SectionTitle('Request Headers'),
                    _JsonContainer(log.requestHeaders!),
                    const SizedBox(height: 16),
                  ],

                  // Request Body
                  if (log.requestBody != null) ...[
                    _SectionTitle('Request Body'),
                    _JsonContainer(log.requestBody),
                    const SizedBox(height: 16),
                  ],

                  // Response Headers
                  if (log.responseHeaders != null && log.responseHeaders!.isNotEmpty) ...[
                    _SectionTitle('Response Headers'),
                    _JsonContainer(log.responseHeaders!),
                    const SizedBox(height: 16),
                  ],

                  // Response Body
                  if (log.responseBody != null) ...[_SectionTitle('Response Body'), _JsonContainer(log.responseBody)],

                  // Error
                  if (log.error != null) ...[
                    const SizedBox(height: 16),
                    _SectionTitle('Error'),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      child: Text(
                        '${log.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 13, fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _JsonContainer extends StatelessWidget {
  final dynamic data;

  const _JsonContainer(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[700]!, width: 1),
      ),
      child: Text(
        _prettyPrint(data),
        style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontFamily: 'monospace'),
      ),
    );
  }

  String _prettyPrint(dynamic data) {
    try {
      if (data is Map || data is List) {
        return const JsonEncoder.withIndent('  ').convert(data);
      }
      return data.toString();
    } catch (e) {
      return data.toString();
    }
  }
}
