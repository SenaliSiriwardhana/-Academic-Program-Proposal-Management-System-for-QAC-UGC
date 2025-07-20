<?php
/**
 * This file renders ONLY the HTML table for the summary sheet.
 * It expects a variable named $summary_data to be defined by the file that includes it.
 */

if (!isset($summary_data) || empty($summary_data)) {
    // Do nothing if there's no data.
    return;
}
?>

<h4 class="mt-4">QAC- UGC Review Summary Sheet</h4>
<table class="table table-striped table-bordered">
    <thead class="table-light">
        <tr>
            <th style="width: 40%;">Section / Field</th>
            <th style="width: 20%;">Status</th>
            <th>Comment</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($summary_data as $item): ?>
            <?php
                $status_class = 'status-' . strtolower(str_replace('_', '-', $item['compliance_status']));
            ?>
            <tr>
                <td><?php echo htmlspecialchars(ucwords(str_replace(['_', '.'], ' ', $item['section_identifier']))); ?></td>
                <td class="<?php echo $status_class; ?>"><?php echo htmlspecialchars(ucwords(str_replace('_', ' ', $item['compliance_status']))); ?></td>
                <td><?php echo nl2br(htmlspecialchars($item['comment'])); ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>